//
//  UsersListViewModel.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 12/02/24.
//

import Foundation
import RxSwift
import RxCocoa

enum UserTableCellType {
    case normal(cellViewModel: GenericUIDataModel)
    case error(message: String)
    case empty
}
class UsersListViewModel {
    
    let disposable = DisposeBag()
    let onShowError = PublishSubject<SingleButtonAlert>()
    
    var users: Observable<[GenericUIDataModel]>?
    var userCells: Observable<[UserTableCellType]> {
        return cells.asObservable()
    }
    var onShowLoading: Observable<Bool> {
        return loadingInProgress
            .asObservable()
            .distinctUntilChanged()
    }
    
    private var loadingInProgress = BehaviorRelay<Bool>(value: false)
    private var cells = BehaviorRelay<[UserTableCellType]>(value: [])

    func getUserData() {
        loadingInProgress.accept(true)
        let service = APIService()
        service.fetchData()
            .subscribe(
                onNext: { [weak self] model in
                    self?.loadingInProgress.accept(false)
                    guard let strongSelf = self else {
                        return
                    }
                    guard model.count > 0 else {
                        return strongSelf.cells.accept([.empty])
                    }
                    strongSelf.cells.accept(model.entries.compactMap{
                        .normal(cellViewModel: GenericUIDataModel(
                            api: $0.api,
                            description: $0.description,
                            category: $0.category))})
                    
                },
                onError: { [weak self] error in
                    self?.loadingInProgress.accept(false)
                    self?.cells.accept([
                        .error(message: (error as? APIService.GetFailureReason)?.getErrorMessage() ?? "Loading failed")
                        ])
                    
                }
            )
            .disposed(by: disposable)
    }
}
