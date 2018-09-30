//
//  ViewController.swift
//  ShopHackVote
//
//  Created by Isabel Lima on 29/09/18.
//  Copyright © 2018 Isabel Lima. All rights reserved.
//

import UIKit

class CollectionViewController : UICollectionViewController {
    
    var votes = [Vote]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        votes.append(Vote(titulo: "Time Cult vs Time Kids", imagem: UIImage(imageLiteralResourceName: "cafekids"), competidor1: Competidor(nome: "Cult", descrip: "As cafeterias participantes vão oferecer desconto de 10% na compra de um café e um salgado ou sobremesa.", tags: ["Cult"]), competidor2: Competidor(nome: "Kids", descrip: "Desconto de 10% em Finis na Planeta Bombom!", tags: ["Kids"])))
        
        votes.append(Vote(titulo: "Time Compras vs Time Gastronomia", imagem: UIImage(imageLiteralResourceName: "shoppersfood"), competidor1: Competidor(nome: "Shoppers", descrip: "Descontos progressivos em peças selecionadas nas lojas participantes!", tags: ["Shopper"]), competidor2: Competidor(nome: "Gastronomia", descrip: "Desconto de 10% na compra de combos nas lojas participantes!", tags: ["Gastronomia"])))
        
        votes.append(Vote(titulo: "Time Cult vs Time Fitness", imagem: UIImage(imageLiteralResourceName: "cinemafitness"), competidor1: Competidor(nome: "Cult", descrip: "As cafeterias participantes vão oferecer desconto de 10% na compra de um café e um salgado ou sobremesa.", tags: ["Cult"]), competidor2: Competidor(nome: "Fitness", descrip: "Desconto de 10% na compra de combos nas lojas participantes!", tags: ["Fitness"])))
        
        votes.append(Vote(titulo: "Time Cult vs Time Compras", imagem: UIImage(imageLiteralResourceName: "cultshopper"), competidor1: Competidor(nome: "Cult", descrip: "20% de desconto na pipoca do cinema!", tags: ["Cult"]), competidor2: Competidor(nome: "Shopper", descrip: "Descontos progressivos em peças selecionadas nas lojas participantes!", tags: ["Compras"])))

    }
    
    
    func sortVotes() {
        votes.sort(by: sortByRelevance)
    }
    
    func sortByRelevance(_ left: Vote, _ right: Vote) -> Bool {
        return getVoteRelevanceScore(vote: left) > getVoteRelevanceScore(vote: right)
    }
    
    func getVoteRelevanceScore(vote: Vote) -> Int {
        var tagCounts: [String: Int] = [:]
        
        for tag in vote.competidores?.0.tags ?? [] {
            tagCounts[tag] = (tagCounts[tag] ?? 0) + 1
        }
        
        for tag in vote.competidores?.1.tags ?? [] {
            tagCounts[tag] = (tagCounts[tag] ?? 0) + 1
        }
        
        var score = 0
        
        for tagCount in tagCounts {
            let isUserPreference = User.shared.profiles[tagCount.key]?.0
            if isUserPreference ?? false {
                score = score + 5
            }
            
            let votes = User.shared.profiles[tagCount.key]?.1 ?? 0
            score += votes
        }
        
        return score
    }
    
    
    private var hiddenCells: [ExpandableCell] = []
    private var expandedCell: ExpandableCell?
    private var isStatusBarHidden = false
    
    override var prefersStatusBarHidden: Bool {
        return isStatusBarHidden
    }
    
    
    
    // MARK: - UICollectionViewDelegates
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return votes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExpandableCell", for: indexPath) as! ExpandableCell
        
        let vote = votes[indexPath.row]
        
        cell.vote = vote
        cell.backgroundImageView.image = vote.banner
        cell.titleVotingLabel.text = vote.title
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
        if collectionView.contentOffset.y < 0 ||
            collectionView.contentOffset.y > collectionView.contentSize.height - collectionView.frame.height {
            return
        }
         */
        
        let dampingRatio: CGFloat = 0.8
        let initialVelocity: CGVector = CGVector.zero
        let springParameters: UISpringTimingParameters = UISpringTimingParameters(dampingRatio: dampingRatio, initialVelocity: initialVelocity)
        let animator = UIViewPropertyAnimator(duration: 0.5, timingParameters: springParameters)
        
        
        self.view.isUserInteractionEnabled = false
        
        if let selectedCell = expandedCell {
            isStatusBarHidden = false
            
            animator.addAnimations {
                selectedCell.collapse()
                
                for cell in self.hiddenCells {
                    cell.show()
                }
            }
            
            animator.addCompletion { _ in
                collectionView.isScrollEnabled = true
                
                self.expandedCell = nil
                self.hiddenCells.removeAll()
            }
        } else {
            isStatusBarHidden = true
            
            collectionView.isScrollEnabled = false
            
            let selectedCell = collectionView.cellForItem(at: indexPath)! as! ExpandableCell
            let frameOfSelectedCell = selectedCell.frame
            
            expandedCell = selectedCell
            hiddenCells = collectionView.visibleCells.map { $0 as! ExpandableCell }.filter { $0 != selectedCell }
            
            animator.addAnimations {
                selectedCell.expand(in: collectionView)
                
                for cell in self.hiddenCells {
                    cell.hide(in: collectionView, frameOfSelectedCell: frameOfSelectedCell)
                }
            }
        }
        
        
        animator.addAnimations {
            self.setNeedsStatusBarAppearanceUpdate()
        }
        
        animator.addCompletion { _ in
            self.view.isUserInteractionEnabled = true
        }
        
        animator.startAnimation()
    }

    
}
