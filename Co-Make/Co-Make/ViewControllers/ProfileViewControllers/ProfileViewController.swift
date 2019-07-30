//
//  ProfileViewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/30/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

   
    @IBOutlet var coreView: UIView!
    
    @IBOutlet var userImageView: UIImageView!
    
    @IBOutlet var userName: UILabel!
    
    @IBOutlet var feedTabBarItem: UITabBarItem!
    
    @IBOutlet var zipcode: UILabel!
    
    @IBOutlet var smallView: UIView!
    
    @IBOutlet var numberOfVotes: UILabel!
    @IBOutlet var numberOfPosts: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.selected)
        
        
        
        
        
        
        coreView.cornerRadius = 15
coreView.shadowOffset = CGSize(width: 0, height: 2)
        coreView.shadowRadius = 3
        coreView.shadowOpacity = 0.5
        userImageView.cornerRadius = 10
        smallView.cornerRadius = 10
     
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
