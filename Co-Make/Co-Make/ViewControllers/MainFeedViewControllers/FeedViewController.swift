//
//  FeedViewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import CoreData

class FeedViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userActualName: UILabel!
    
    @IBOutlet var userAddress: UILabel!
    
    @IBOutlet var issuesTableView: UITableView!
    @IBOutlet var feedTabBarItem: UITabBarItem!
    
    @IBOutlet var searchIssues: UISearchBar!
    
    let apiController = ApiController()
    
    let sampleData = ["sampledata"]
    
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
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.selected)
        
        
        searchIssues.cornerRadius = 20
        userImage.image = UIImage(named: "sign-in-4")
        userImage.cornerRadius = 23
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        guard let userID = fetchedResultsController.fetchedObjects?[0].userID else {
            
            // Segue to sign up
            return
        }
        
        let user = fetchedResultsController.fetchedObjects?[0]
        guard let email = user?.email,
            let password = user?.password else { return }
        apiController.signIn(with: email, password: password)
        
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
extension FeedViewController: UITableViewDelegate{
    
}
extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = issuesTableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueTableViewCell else {return UITableViewCell()}
        
        let selectedIssue = sampleData[indexPath.row]
        
        cell.firstFIlterType.text = selectedIssue
        cell.issueCreator.text = selectedIssue
        cell.issueTitle.text = selectedIssue
        cell.numberOfUpVotes.text = "5 Votes"
        cell.secondFilterType.text = selectedIssue
        cell.issueImage.cornerRadius = 15
        cell.issueImage.image = UIImage(named: "sign-in-4")
        
        return cell
    }
    
    
}
