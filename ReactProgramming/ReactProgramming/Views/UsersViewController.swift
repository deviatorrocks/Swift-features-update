//
//  ViewController.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 08/02/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, SingleButtonDialogPresenter {
    
    @IBOutlet weak var userListView: UITableView!
    
    private let disposeBag = DisposeBag()
    private let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    
    var viewModel = UsersListViewModel()
    var sequence = Observable.of("Hello world")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        let subscription: () = sequence.subscribe { event in
//            switch event {
//            case .next(let value):
//                print(value)
//            case .error(let error):
//                break
//            case .completed:
//                break
//            }
//        }.dispose()
        bindViewModel()
        viewModel.getUserData()
    }
    
    func bindViewModel() {
        viewModel.userCells.bind(to: self.userListView.rx.items) { tableview, index, element in
            let indexPath = IndexPath(row: index, section: 0)
            switch element {
            case .normal(let model):
                guard let cell = tableview.dequeueReusableCell(withIdentifier: "GenericTableViewCell", for: indexPath) as? GenericTableViewCell else {
                    return UITableViewCell()
                }
                cell.genericDataModel = model
                return cell
            case .error(let message):
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = true
                cell.textLabel?.text = message
                return cell
            case .empty:
                let cell = UITableViewCell()
                cell.isUserInteractionEnabled = true
                cell.textLabel?.text = "No data available"
                return cell
            }
        }.disposed(by: disposeBag)
        
        viewModel
            .onShowError
            .map { [weak self] in self?.presentSingleButtonDialog(alert: $0) }
            .subscribe()
            .disposed(by: disposeBag)
        
        viewModel
            .onShowLoading
            .map{ [weak self] in self?.displayLoadingIndicator(visible: $0) }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func displayLoadingIndicator(visible: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else {
                return
            }
            let loadingView = strongSelf.activityIndicatorView
            if visible {
                strongSelf.view.addSubview(loadingView)
                strongSelf.view.bringSubviewToFront(loadingView)
                loadingView.startAnimating()
            } else {
                loadingView.stopAnimating()
                loadingView.removeFromSuperview()
            }
        }
    }
}

