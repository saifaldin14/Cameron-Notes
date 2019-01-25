//
//  Home.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-05-29.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit
import CoreData

class Home: UIViewController, UITextFieldDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Round profile image
        //Make Profile Image Icon circular
        profileImage.layer.borderWidth = 1
        profileImage.layer.masksToBounds = false
        profileImage.layer.borderColor = UIColor(white: 1, alpha:0.5).cgColor
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        profileImage.image = #imageLiteral(resourceName: "Profile-Image")
        profileImage.backgroundColor = UIColor.lightGray
        
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Core Data fetching for profile
    func getData() {
        guard (UIApplication.shared.delegate as? AppDelegate) != nil else {return}
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let ProfileRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Profile")
        
        do {
            let fetchRequest = try context.fetch(ProfileRequest)
            
            if fetchRequest.count > 0 {
                for result in fetchRequest as! [NSManagedObject]{
                    nameLabel.text = result.value(forKey: "name") as? String
                    bioLabel.text = result.value(forKey: "bio") as? String
                    profileImage.image = UIImage(data: result.value(forKey: "profilePicture") as! Data)
                }
            }
        } catch let err as NSError{
            print("Failed to fetch items", err)
        }
    }

}
