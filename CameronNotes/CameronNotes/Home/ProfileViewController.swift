//
//  ProfileViewController.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-03-17.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit
import CoreData

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var ProfileImageView: UIImageView!
    @IBOutlet weak var NameView: UITextField!
   
    @IBOutlet weak var BioView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ProfileImageView.isUserInteractionEnabled = true
        ProfileImageView.addGestureRecognizer(tapGestureRecognizer)
        ProfileImageView.image = #imageLiteral(resourceName: "Profile-Image")
        ProfileImageView.backgroundColor = UIColor.lightGray
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When the image is tapped go to the camera roll
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        ProfileImageView.image = image
        ProfileImageView.contentMode = .scaleAspectFill
        dismiss(animated: true, completion: nil)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        present(controller, animated: true, completion: nil)
        
        // Your action
    }
    //Moves Textfield out fo the way when the user clicks
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -250, up: true)
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
            moveTextField(textField: textField, moveDistance: -250, up: false)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3//Moves it smoothly (it's not just flying out of the way)
        let movement : CGFloat = CGFloat(up ? moveDistance : -moveDistance)//In line if-statement
        
        UIView.beginAnimations("animationID", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0.0, dy: movement)
        UIView.commitAnimations()
        
    }
    //Moves the bio textview out of the way when the user clicks
    func textViewDidBeginEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        moveTextView(textView: textView, moveDistance: -250, up: false)
    }
    //Dismisses the keyborad when return is pressed
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func moveTextView(textView: UITextView, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement : CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animationID", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0.0, dy: movement)
        UIView.commitAnimations()
        
    }
    
    //Saves the data to Core Data when save button is clicked
    @IBAction func SaveButton(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let profile = Profile(context: context)
        
        let imageData : NSData = (UIImagePNGRepresentation(ProfileImageView.image!) as NSData?)!
        
        profile.profilePicture = imageData as Data
        profile.name = NameView.text!
        profile.bio = BioView.text!
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //Back Button
    @IBAction func prepareForUnwind (segue: UIStoryboardSegue) {
        
    }
}
