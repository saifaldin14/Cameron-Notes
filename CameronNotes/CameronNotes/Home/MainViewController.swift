//
//  ViewController.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-03-11.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit
import CoreData

//MARK: Struct for required data
//Structs to hold data for custom feautres
//This one is for the scrollView
struct requiredData {
    let title : String?
    let image : UIImage?
}

class MainViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate{
    
    var scrollViewData = [requiredData]()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var homeScrollView: UIScrollView!
        
    var viewTagValue = 10
    let tagValue = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeScrollView.delegate = self
        //Set data of scrollView
        scrollViewData = [requiredData.init(title: "Courses", image: #imageLiteral(resourceName: "Course-Image")), requiredData.init(title: "Tasks", image: #imageLiteral(resourceName: "Tasks-Image")), requiredData.init(title: "Calendar", image: #imageLiteral(resourceName: "Calendar-Image"))]
        
        homeScrollView.contentSize.width = self.homeScrollView.frame.width * CGFloat(scrollViewData.count)
        
        //Set the rows for the scrollView and initialize all of the feautres that go with it (label, image)
        var i = 0
        for data in scrollViewData {
            //MARK: View Initilizer within ScrollView
            let view = CustomView(frame: CGRect(x: 10 + (self.homeScrollView.frame.width * CGFloat(i)), y: 80, width: self.homeScrollView.frame.width - 20, height: self.homeScrollView.frame.height - 90))
            view.imageView.image = data.image
            
            //MARK: Gesture Recognizer
            //Adds a tap gesture to the images
            var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            view.imageView.isUserInteractionEnabled = true
            //Chooses which view controller to go to when image is tapped
            if view.imageView.image == #imageLiteral(resourceName: "Course-Image") {
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            } else if view.imageView.image == #imageLiteral(resourceName: "Tasks-Image") {
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped2(tapGestureRecognizer:)))
            } else if view.imageView.image == #imageLiteral(resourceName: "Calendar-Image") {
                tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped3(tapGestureRecognizer:)))
            }
            view.imageView.addGestureRecognizer(tapGestureRecognizer)//Implements the tap gesture
            
            self.homeScrollView.addSubview(view)
            view.tag = i + viewTagValue
            
            //Mark: Label Initilizer
            let label = UILabel(frame: CGRect.init(origin: CGPoint.init(x: 0, y: 20), size: CGSize.init(width: 0, height: 40)))
            label.text = data.title
            label.font = UIFont.boldSystemFont(ofSize: 30)
            label.textColor = UIColor.black
            label.sizeToFit()//resizes the label
            label.tag = i + tagValue
            if i == 0 {
                label.center.x = view.center.x
            } else {
               label.center.x = view.center.x - self.homeScrollView.frame.width / 2
                //offsets the label to be right ouside of the view
            }
            self.homeScrollView.addSubview(label)
            
        //Stays at the bottom
        i += 1
        }

        //MARK: Round profile image
        //Make Profile Image Icon circular
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.borderColor = UIColor(white: 1, alpha:0.5).cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.clipsToBounds = true
        profileImageView.image = #imageLiteral(resourceName: "Profile-Image")
        profileImageView.backgroundColor = UIColor.lightGray
        
        getData()
    }
    
    //MARK: Scroll detection action
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if homeScrollView == homeScrollView {//to make sure that this function doesn't get called for all scrollviews, only the homeScrollView will get called
            
            for i in 0..<scrollViewData.count {
                let label = homeScrollView.viewWithTag(i + tagValue) as! UILabel
                let view = homeScrollView.viewWithTag(i + viewTagValue) as! CustomView
                let scrollContentOffset = homeScrollView.contentOffset.x + self.homeScrollView.frame.width
                let viewOffset = (view.center.x - homeScrollView.bounds.width / 4) - scrollContentOffset
                label.center.x = scrollContentOffset - ((homeScrollView.frame.width / 4 - viewOffset)/2)
            }
        }
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
                    profileImageView.image = UIImage(data: result.value(forKey: "profilePicture") as! Data)
                }
            }
        } catch let err as NSError{
            print("Failed to fetch items", err)
        }
    }
    
    //MARK: Image recognizer functions
    //Actions to be implemented when image is clicked (segue to another view controller
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "courseIdentifier", sender: nil)
    }
    @objc func imageTapped2(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "tasksIdentifier", sender: nil)
    }
    @objc func imageTapped3(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "calendarIdentifer", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



class CustomView:UIView {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = UIColor.white
        
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        
        //Sets constraints for the scrollView
        imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

