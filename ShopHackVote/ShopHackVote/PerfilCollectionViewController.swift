//
//  PerfilCollectionViewController.swift
//  ShopHackVote
//
//  Created by Ian Manor on 30/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit
import FirebaseDatabase

private let reuseIdentifier = "ProfileCell"

class PerfilCollectionViewController: UICollectionViewController {
    
    var profiles = ["Cult", "Família", "Gastronomia", "Shopper", "Teen", "Kids", "Fitness"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return profiles.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ProfileCollectCollectionViewCell
    
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        // Configure the cell
        let profile = profiles[indexPath.row]
        cell.profileLabel.text = profile
        cell.imageView.image = UIImage(named: profile)
        cell.backgroundColor = User.shared.profiles[profile]!.0 ? UIColor.lightGray : UIColor.clear
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let profile = profiles[indexPath.row]
        
        let userProfile = User.shared.profiles[profile]
        
        User.shared.profiles[profile] = (!userProfile!.0, userProfile!.1)
 //       saveDataatFirebase(indexPath: indexPath.row)
        
        collectionView.reloadData()
    }
    
    func saveDataatFirebase(indexPath: Int) {
        var value: [String: Any]
        value = [profiles[indexPath]: User.shared.profiles[profiles[indexPath]]!]
        
        let ref = Database.database().reference().child(profiles[indexPath]).childByAutoId()
        
        ref.updateChildValues(value) { (err, dataref) in
            if err != nil {
                print(err)
                return
            }
            
            // success on saving profiles at database
            print("yay")
        }
        
    }
    
}
