//
//  BackSegue.swift
//  CameronNotes
//
//  Created by Saif Al-Din Ali on 2018-04-12.
//  Copyright © 2018 Saif Al-Din Ali. All rights reserved.
//

import UIKit

class BackSegue: UIStoryboardSegue {

    override func perform() {
        scale()
    }
    
    func scale() {
        let toViewController = self.destination
        let fromViewController = self.source
        
        let containerView = fromViewController.view.superview
        let orginalCenter = fromViewController.view.center
        
        toViewController.view.transform = CGAffineTransform(scaleX: 0.05, y: 0.05)
        toViewController.view.center = orginalCenter
        
        containerView?.addSubview(toViewController.view)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: { toViewController.view.transform = CGAffineTransform.identity
        }, completion: { success in
            fromViewController.present(toViewController, animated: false, completion: nil)
        })
    }
}
