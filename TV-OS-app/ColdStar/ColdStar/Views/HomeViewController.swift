//
//  HomeViewController.swift
//  ColdStar
//
//  Created by ZMO-MAC-MandarK-01 on 10/01/24.
//

import UIKit

enum CellTypes: Int, CaseIterable {
    case carousal
    case latestVideos
    case classified
    case tools
}

class HomeViewController: UIViewController {
    @IBOutlet weak var homeTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        homeTableView.register(UINib(nibName: "VideosTableViewCell", bundle: nil),
                               forCellReuseIdentifier: "VideosTableViewCell")
        homeTableView.estimatedRowHeight = 360
        homeTableView.rowHeight = UITableView.automaticDimension
        homeTableView.reloadData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let videoTableCell: VideosTableViewCell = tableView.dequeueReusableCell(
            withIdentifier: "VideosTableViewCell",
            for: indexPath) as? VideosTableViewCell,
            let cellType = CellTypes(rawValue: indexPath.row) {
            videoTableCell.type = cellType
            switch videoTableCell.type {
            case .carousal:
                videoTableCell.titleLabel.isHidden = true
                videoTableCell.heightConstraint.constant = 540
            case .latestVideos:
                videoTableCell.titleLabel.isHidden = false
                videoTableCell.titleLabel.text = "Latest videos"
                videoTableCell.heightConstraint.constant = 360
            case .classified:
                videoTableCell.titleLabel.isHidden = false
                videoTableCell.titleLabel.text = "Classified"
                videoTableCell.heightConstraint.constant = 360
                videoTableCell.videoCollectionView.reloadData()
            case .tools:
                videoTableCell.titleLabel.isHidden = false
                videoTableCell.titleLabel.text = "Useful tools"
                videoTableCell.heightConstraint.constant = 360
                videoTableCell.videoCollectionView.reloadData()
            }
            videoTableCell.backgroundColor = .clear
            return videoTableCell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellTypes.allCases.count
    }

    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}

