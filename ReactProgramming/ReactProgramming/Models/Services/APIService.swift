//
//  APIService.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 12/02/24.
//

import Foundation
import RxSwift

enum Result<T, U> where U: Error {
    case success(payload: T)
    case fail(U?)
}

class APIService {
    
    enum GetFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
        case urlImproper = 555
    }
    
    typealias GetListView = Result<Generic, GetFailureReason>
    typealias GetResponseCompletion = (_ result: GetListView) -> Void
    
//    func fetchInfo(completion: @escaping GetResponseCompletion) {
//        guard let request = URL(string: "https://api.publicapis.org/entries") else {
//            return completion(.fail(.urlImproper))
//        }
//        Alamofire.request("https://api.publicapis.org/entries")
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .success:
//                    do {
//                        let model = try JSONDecoder().decode(Generic.self, from: response.data ?? Data())
//                        completion(.success(payload: model))
//                    } catch(let error) {
//                        completion(.fail(.notFound))
//                    }
//                case .failure(_):
//                    completion(.fail(.notFound))
//                }
//            }
//    }
    
    func fetchData() -> Observable<Generic> {
        return Observable.create { observer in
            guard let request = URL(string: "https://api.publicapis.org/entries") else {
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(
                with: URLRequest(url: request)) { data, response, error in
                    do {
                        let model = try JSONDecoder().decode(Generic.self, from: data ?? Data())
                        observer.onNext(model)
                    } catch(let error) {
                        observer.onError(error)
                    }
                    observer.onCompleted()
                }
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        }
    }
}

extension APIService.GetFailureReason {
    func getErrorMessage() -> String? {
        switch self {
        case .unAuthorized:
            return "Please login to load users."
        case .notFound:
            return "Could not complete request, please try again."
        case .urlImproper:
            return "Url is improper"
        }
    }
}
