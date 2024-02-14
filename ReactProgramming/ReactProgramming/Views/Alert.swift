//
//  Alert.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 13/02/24.
//

import UIKit

struct AlertAction {
    let buttonTitle: String
    let handler: (() -> Void)?
}

struct SingleButtonAlert {
    let title: String
    let message: String?
    let action: AlertAction
}
