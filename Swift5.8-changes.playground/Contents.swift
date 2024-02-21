import UIKit
import SwiftUI

var greeting = "Hello, playground"
enum UserState {
    case subscriber, nonsubscriber, none
}
struct User {
    var id: Int
    var name: String
}

//class SubscriberView: View {
//    @State private var userState = UserState.none
//    var body: some View {
//        ZStack {
//            lazy var user = fetchUsername()
//            switch userState {
//            case .subscriber:
//                break
//            case .unsubscriber:
//                break
//            case .none:
//                print("doSomething with user: \(user)")
//
//            }
//        }
//    }
//
//    func fetchUsername() -> User {
//        return User(id: 123, name: "Maddy")
//    }
//}


class TimerController {
    var timer: Timer?
    var fireCount = 0
    
    init() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true, block: { [weak self] value in
            guard let self else { return }
            fireCount += 1
            print(fireCount)
        })
    }
}


TimerController()
