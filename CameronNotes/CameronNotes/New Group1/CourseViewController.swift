//
//  CourseViewController.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-05-31.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit

class CourseViewController: UIViewController {
    
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var courseCollectionView: UICollectionView!
    
    let dataModel = [#imageLiteral(resourceName: "Math-Class"), #imageLiteral(resourceName: "English-Class"), #imageLiteral(resourceName: "Photo-Class"), #imageLiteral(resourceName: "Chemsitry-Class")]
    let textModel = ["Math Class", "English Class", "Photography Class", "Chemistry Class"]
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        courseCollectionView.dataSource = self
        if let layout = courseCollectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "courseIdentifier", sender: nil)
    }
}

extension CourseViewController: UICollectionViewDataSource, PinterestLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = courseCollectionView.dequeueReusableCell(withReuseIdentifier: "courseCell", for: indexPath) as? CourseCollectionViewCell {
            cell.courseImageView.image = dataModel[indexPath.row]
            cell.courseLabel.text = textModel[indexPath.row]
            cell.clipsToBounds = true
            cell.layer.cornerRadius = 15
            cell.courseImageView.contentMode = .scaleAspectFill
            return cell
        }
        return CourseCollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        let height = dataModel[indexPath.row].size.height
        
        return height
    }
    
}
