//
//  ThemeTableViewController.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-06-02.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit

class ThemeTableViewController: UITableViewController {

    let courseModel = [#imageLiteral(resourceName: "math-class-2"), #imageLiteral(resourceName: "science-class"), #imageLiteral(resourceName: "gym-class"), #imageLiteral(resourceName: "history-class"), #imageLiteral(resourceName: "art-class"), #imageLiteral(resourceName: "psychology-class"), #imageLiteral(resourceName: "photo-class"),#imageLiteral(resourceName: "code-class"), #imageLiteral(resourceName: "book-class"), #imageLiteral(resourceName: "cooking-class")]
    let courseTitle = ["Math Class", "Science Class", "Gym Class", "History Class", "Art Class", "Psychology Class", "Photography Class", "Programming Class", "English Class", "Culenary Class"]
    override func viewDidLoad() {
        super.viewDidLoad()
        //var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        performSegue(withIdentifier: "addCourse", sender: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? AddThemeTableViewCell
        cell?.themeImageview.image = courseModel[indexPath.row]
        cell?.themeLabel.text = courseTitle[indexPath.row]
        cell?.themeImageview.contentMode = .scaleAspectFill
        cell?.clipsToBounds = true
        cell?.layer.cornerRadius = 15
        cell?.themeImageview.isUserInteractionEnabled = true
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        
        cell?.themeImageview.addGestureRecognizer(tapGestureRecognizer)
        
        return cell!
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
