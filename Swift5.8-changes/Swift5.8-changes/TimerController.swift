//
//  TimerController.swift
//  Swift5.8-changes
//
//  Created by ZMO-MAC-MandarK-01 on 14/12/23.
//

import Foundation
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
