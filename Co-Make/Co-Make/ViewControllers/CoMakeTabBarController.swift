//
//  CoMakeTabBarController.swift
//  Co-Make
//
//  Created by Kat Milton on 7/31/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import CoreData

class CoMakeTabBarController: UITabBarController, NSFetchedResultsControllerDelegate {
    
    var apiController = ApiController()
    
    lazy var fetchedResultsController: NSFetchedResultsController<User> = {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        let userIDDescriptor = NSSortDescriptor(key: "userID", ascending: false)
        
        
        fetchRequest.sortDescriptors = [userIDDescriptor]
        let moc = CoreDataStack.shared.mainContext
        
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: moc, sectionNameKeyPath: "userID", cacheName: nil)
        
        frc.delegate = self
        
        do {
            try frc.performFetch()
        } catch {
            fatalError("Error performing fetch: \(error)")
        }
        return frc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        guard let barViewControllers = self.viewControllers else { return }
       
        let feedVC = barViewControllers[0] as! FeedViewController

        feedVC.apiController = apiController
        feedVC.fetchedResultsController = fetchedResultsController
        
        let createIssueVC = barViewControllers[1] as! CreateIssueViewController
        createIssueVC.apiController = apiController
        createIssueVC.fetchedResultsController = fetchedResultsController
        
        let profileVC = barViewControllers[2] as! ProfileViewController
        profileVC.apiController = apiController
        profileVC.fetchedResultsController = fetchedResultsController
        
    
        
      
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if fetchedResultsController.fetchedObjects?.count == 0 {
            showSignupModally()
        }
    }
    
    func showSignupModally() {
        let pagesVC = PageViewController()
        pagesVC.modalPresentationStyle = .fullScreen
        present(pagesVC, animated: true, completion: nil)
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
