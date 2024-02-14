//
//  UserUIDataModel.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 13/02/24.
//

import Foundation

struct GenericUIDataModel {
    let api, description: String
    let category: String
}

extension GenericUIDataModel {
    init(model: Entry) {
        self.api = model.api
        self.category = model.category
        self.description = model.description
    }
}
