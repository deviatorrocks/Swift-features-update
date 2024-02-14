//
//  GenericTableViewCell.swift
//  ReactProgramming
//
//  Created by ZMO-MAC-MandarK-01 on 13/02/24.
//

import Foundation
import UIKit

class GenericTableViewCell: UITableViewCell {
 
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var genericDataModel: GenericUIDataModel? {
        didSet {
            bindUIDataModel()
        }
    }
    
    func bindUIDataModel() {
        if let model = genericDataModel {
            self.categoryLabel.text = model.category
            self.descriptionLabel.text = model.description
        }
    }
}
