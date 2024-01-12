//
//  ClassifiedViewCell.swift
//  ColdStar
//
//  Created by ZMO-MAC-MandarK-01 on 10/01/24.
//

import Foundation
import UIKit

class ClassifiedViewCell: UICollectionViewCell {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    var type: CellTypes = .classified
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = containerView.frame.size.height/2
        containerView.clipsToBounds = true
        containerView.backgroundColor = .random
        containerView.layer.borderWidth = 10
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false {
                self?.containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self?.containerView.layer.borderColor = UIColor.white.cgColor
                self?.titleLabel.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            } else {
                self?.containerView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self?.containerView.layer.borderColor = UIColor.clear.cgColor
                self?.titleLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }, completion: nil)
    }
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0.65...1),
                       green: .random(in: 0.65...1),
                       blue: .random(in: 0.65...1),
                       alpha: 0.8)
    }
}
