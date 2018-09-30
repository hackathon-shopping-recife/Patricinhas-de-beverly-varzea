//
//  ExpandableCell.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 29/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//
import UIKit
import FaveButton
import GTProgressBar

class ExpandableCell: UICollectionViewCell, Expandable, FaveButtonDelegate {
    
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool) {
        if faveButton.tag == 1 {
            let otherButton = self.contentView.viewWithTag(2) as! FaveButton
            if otherButton.isSelected {
                otherButton.isSelected = false
                deselectTags(tags: tags2)
            }
            selectTags(tags: tags1)
        } else {
            let otherButton = self.contentView.viewWithTag(1) as! FaveButton
            if otherButton.isSelected {
                otherButton.isSelected = false
                deselectTags(tags: tags1)
            }
            selectTags(tags: tags2)
        }
    }
    
    
    @IBOutlet weak var detailsTableView: SelfSizedTableView!

    
    var vote: Vote?
    
    var tags1: [String] = ["Cult"]
    var tags2: [String] = ["Fitness"]
    
    func selectTags(tags: [String]) {
        for tag in tags {
            User.shared.profiles[tag] = (User.shared.profiles[tag]!.0, User.shared.profiles[tag]!.1 + 1)
        }
    }
    
    func deselectTags(tags: [String]) {
        for tag in tags {
            User.shared.profiles[tag] = (User.shared.profiles[tag]!.0, User.shared.profiles[tag]!.1 - 1)
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    // Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleVotingLabel: UILabel!
    
    private var initialFrame: CGRect?
    private var initialCornerRadius: CGFloat?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureAll()
    }
    
    // MARK: - Configuration
    
    private func configureAll() {
        
        
        
        detailsTableView.allowsSelection = true
        //detailsTableView.isUserInteractionEnabled = false
        detailsTableView.separatorStyle = .none
        //detailsTableView.register(VoteDescriptionTableViewCell.self, forCellReuseIdentifier: "VoteDescriptionCell")
        //detailsTableView.register(VotePercentageTableViewCell.self, forCellReuseIdentifier: "VotePercentageCell")
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        
        configureCell()
        
        // Progress bar setup
       
    }
    
    private func configureCell() {
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = self.contentView.layer.cornerRadius
    }
    
    // MARK: - Showing/Hiding Logic
    
    func hide(in collectionView: UICollectionView, frameOfSelectedCell: CGRect) {
        initialFrame = self.frame
        
        let currentY = self.frame.origin.y
        let newY: CGFloat
        
        if currentY < frameOfSelectedCell.origin.y {
            let offset = frameOfSelectedCell.origin.y - currentY
            newY = collectionView.contentOffset.y - offset
        } else {
            let offset = currentY - frameOfSelectedCell.maxY
            newY = collectionView.contentOffset.y + collectionView.frame.height + offset
        }
        
        self.frame.origin.y = newY
        
        layoutIfNeeded()
    }
    
    func show() {
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        
        layoutIfNeeded()
    }
    
    // MARK: - Expanding/Collapsing Logic
    
    func expand(in collectionView: UICollectionView) {
        initialFrame = self.frame
        initialCornerRadius = self.contentView.layer.cornerRadius
        
        self.contentView.layer.cornerRadius = 0
        self.frame = CGRect(x: 0, y: collectionView.contentOffset.y, width: collectionView.frame.width, height: collectionView.frame.height)
        
        layoutIfNeeded()
    }
    
    func collapse() {
        self.contentView.layer.cornerRadius = initialCornerRadius ?? self.contentView.layer.cornerRadius
        self.frame = initialFrame ?? self.frame
        
        initialFrame = nil
        initialCornerRadius = nil
        
        layoutIfNeeded()
    }
    
}

extension ExpandableCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //number of vote options
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    /*
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 80
        } else {
            return 40
        }
    }
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VotePercentageCell", for: indexPath) as! VotePercentageTableViewCell
            //cell.percentageLabel.text = "boo"
//            cell.percentageSlider.setThumbImage(UIImage(), for: .normal)
//            cell.percentageSlider.isUserInteractionEnabled = false
//            cell.percentageSlider.maximumTrackTintColor = .clear
//            cell.percentageSlider.setMinimumTrackImage(UIImage(color: cell.percentageSlider.tintColor), for: .normal)
            
            cell.percentageLabel.text = "50%"
            cell.percentageLabel.sizeToFit()
            
            //cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "VoteDescriptionCell", for: indexPath) as! VoteDescriptionTableViewCell
            
            //cell.selectionStyle = .none
            
            if indexPath.row == 0 {
                
                cell.titleLabel.text = vote?.competidores?.0.name
                cell.descriptionLabel.text = vote?.competidores?.0.description
                cell.percentageLabel.text = "64%"
                cell.voteButton.delegate = self
                cell.voteButton.tag = 1
                
                
            } else if indexPath.row == 1 {
                cell.titleLabel.text = vote?.competidores?.1.name
                cell.descriptionLabel.text = vote?.competidores?.1.description
                cell.percentageLabel.text = "36%"
                cell.voteButton.delegate = self
                cell.voteButton.tag = 2
                
                cell.titleLabel.sizeToFit()
                cell.descriptionLabel.sizeToFit()
            }
            
            return cell
        }
        
    }
}

class CustomSlide: UISlider {
    
    @IBInspectable var trackHeight: CGFloat = 2
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        //set your bounds here
        //return super.trackRect(forBounds: bounds)
        return CGRect(origin: CGPoint(x: bounds.origin.x, y: bounds.origin.y + 2), size: CGSize(width: bounds.width, height: trackHeight))
    }
}

public extension UIImage {
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
