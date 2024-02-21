//
//  ViewController.swift
//  Swift-5.8-updates
//
//  Created by ZMO-MAC-MandarK-01 on 14/12/23.
//

import UIKit

class ViewController: UIViewController {

    var fireCountInCity = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //_ = TimerController()
        performTasks()
        let person = Person(name: "mandar", age: 34)
        var anotherPerson = person
        anotherPerson.age = 37
        anotherPerson.name = "Elon"
        
        print(person.age, person.name)
        print(anotherPerson.age, anotherPerson.name)
        
        
        let list = [1, 2, 3, 4, 2, 4, 2, 56, 34, 45]
        let map = list.map{ $0%2 }
        let stringArray = list.map { a in
            return "\(a)"
        }
        let oddNumber = list.filter{ $0%2 == 0 }
        let sort = list.sorted(by: >)
        
        print(stringArray)
        print(sort)
        print(map)
        print(oddNumber)
        
        performSwiftFeatures(age: 25)
        performSwiftFeatures(age: 12)
        
        print(expressionsChanges(score: 600))
        print(expressionsChangesInSwitch(score: 100))
        
        performNonCopyableStruct()
        functionParameterNonCopyable()
        
        performMissionImpMessage()
    }
    
    func performSwiftFeatures(age: Int) {
        let bounsadult = age > 18 ? 1 : 1.5
        let bonusAdult1 = if age > 18 { 1.5 } else { 1.0 }
        print(bounsadult)
        print(bonusAdult1)
        print("-----")
    }
    
    func performNonCopyableStruct() {
        let user = User(name: "Mandar")
        let newuser = user
        // print(user.name) Will give compile time error since newuser is the one which holds the copy of user now. Line no-59
        print("Non copyable feature of struct using (~Copyable): \(newuser.name)")
    }
    
    func functionParameterNonCopyable() {
        let user = User(name: "ABC")
        print(user.name)
        greetUser(user: user)
        print("Say good bye to user: \(user.name)")
    }
    
    func greetUser(user: borrowing User) {
        print("How are you user: \(user.name)")
    }
    
    
    func performSerialExecution() {
        let queue = DispatchQueue(label: "Serial queue")
        queue.async { [weak self] in
            guard let self else {
                return
            }
            self.fireCountInCity = self.fireCountInCity + 1
            print("in serial: \(String(describing: self.fireCountInCity))")
        }
    }
    
    func performParallelExecution() {
        let queue = DispatchQueue(label: "Parallel", attributes: .concurrent)
        queue.async(flags: .barrier) { [weak self] in
            guard let self else {
                return
            }
            
            DispatchQueue.main.async {
                self.fireCountInCity = self.fireCountInCity + 1
                print("in parallel: \(String(describing: self.fireCountInCity))")
            }
        }
    }
    
    func performMissionImpMessage() {
        let message = MissionImpossibleMessage(message: "Codes are: 142345")
        message.readMessage()
    }
    func performTasks() {
        performParallelExecution()
        performParallelExecution()
    }
    
    func expressionsChanges(score: Int) -> String {
        if score > 500  {"Pass"} else {"fail"}
    }
    
    func expressionsChangesInSwitch(score: Int) -> String {
        switch score {
        case 0...400: "Dimerit"
        case 400...600: "HSC"
        case 600...800: "First class"
        case 800...100: "Distinction"
        default:
            "fail"
        }
    }
}

class TimerController {
    var timer: Timer?
    var fireCount = 0
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(performTask), userInfo: nil, repeats: true)
    }
    
    @objc func performTask() {
        fireCount += 1
        print(fireCount)
    }
}


struct Person {
    var name: String = ""
    var age: Int = 0
    
//    init(name: String, age: Int) {
//        self.name = name
//        self.age = age
//    }
}


struct User: ~Copyable {
    var name: String
}


struct MissionImpossibleMessage: ~Copyable {
    var message: String
    init(message: String) {
        self.message = message
    }
    
    func readMessage() {
        print(message)
    }
}
