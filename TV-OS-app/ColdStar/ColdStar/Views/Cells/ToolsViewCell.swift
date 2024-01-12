//
//  ToolsViewCell.swift
//  ColdStar
//
//  Created by ZMO-MAC-MandarK-01 on 10/01/24.
//

import Foundation
import UIKit

class ToolsViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    var type: CellTypes = .tools
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 10
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false {
                self?.imageView.transform = self?.type == .carousal ? CGAffineTransform(scaleX: 1.01, y: 1.01) : CGAffineTransform(scaleX: 1.05, y: 1.05)
                self?.imageView.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self?.imageView.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
}
