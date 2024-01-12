//
//  LatestsViewCell.swift
//  ColdStar
//
//  Created by ZMO-MAC-MandarK-01 on 10/01/24.
//

import Foundation
import UIKit

class VideosTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var videoCollectionView: UICollectionView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    var type: CellTypes = .latestVideos
    
    var latestVideos = ["appleSignIn","lazyView","appleSignIn","inheritance","copyOnWrite","methodDispatch"]
    var carousal = ["tvOS_development","iCode_Banner_Small"]
    var classifiedVideos = ["Interviews", "Swift UI", "Core Concepts", "DSA"]
    var toolVideos = ["simsim","instruments","pusher"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerNibs()
        videoCollectionView.delegate = self
        videoCollectionView.dataSource = self
        videoCollectionView.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    private func registerNibs() {
        videoCollectionView.register(UINib(nibName: "VideosCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "VideosCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ClassifiedCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ClassifiedCollectionViewCell")
        videoCollectionView.register(UINib(nibName: "ToolsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ToolsCollectionViewCell")
    }
}

extension VideosTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .carousal:
            return carousal.count
        case .classified:
            return classifiedVideos.count
        case .tools:
            return toolVideos.count
        case .latestVideos:
            return latestVideos.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .carousal:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                cell.type = type
                cell.imageView.image = UIImage(named: carousal[indexPath.row])
                cell.contentMode = .scaleAspectFill
                return cell
            }
            return UICollectionViewCell()
        case .latestVideos:
            if let cell: VideosCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideosCollectionViewCell", for: indexPath) as? VideosCollectionViewCell {
                cell.type = type
                cell.imageView.image = UIImage(named: latestVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case .tools:
            if let cell: ToolsViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ToolsCollectionViewCell", for: indexPath) as? ToolsViewCell {
                cell.type = type
                cell.imageView.image = UIImage(named: toolVideos[indexPath.row])
                return cell
            }
            return UICollectionViewCell()
        case .classified:
            if let cell: ClassifiedViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassifiedCollectionViewCell", for: indexPath) as? ClassifiedViewCell {
                cell.type = type
                cell.titleLabel.text = classifiedVideos[indexPath.row]
                return cell
            }
            return UICollectionViewCell()
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        switch type {
        case .carousal:
            return CGSize(width: collectionView.frame.size.width - 180, height: collectionView.frame.size.height)
        case .classified:
            return CGSize(width: 360, height: 360)
        case .latestVideos, .tools:
            return CGSize(width: (16/10) * collectionView.frame.size.height, height: collectionView.frame.size.height)
        }
    }
}
