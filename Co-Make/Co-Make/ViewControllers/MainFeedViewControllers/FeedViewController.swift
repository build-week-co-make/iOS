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
    
    var apiController: ApiController?
    
    let sampleData = ["sampledata"]
    
    var fetchedResultsController: NSFetchedResultsController<User>?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.selected)
        
        
        searchIssues.cornerRadius = 20
        userImage.image = UIImage(named: "sign-in-4")
        userImage.cornerRadius = 23
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
     
        guard let user = fetchedResultsController?.fetchedObjects?[0],
            let username = user.username else { return }
        
        userActualName.text = username
        
        apiController?.fetchIssuesFromServer()
        
    }
    
    
    
    
    
    
     // MARK: - Navigation
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "" {
            
        }
     }
    
    
}
extension FeedViewController: UITableViewDelegate{
    
}
extension FeedViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return apiController?.issues.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = issuesTableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueTableViewCell else {return UITableViewCell()}
        
        let selectedIssue = apiController?.issues[indexPath.row]
        
       cell.issue = selectedIssue
        
        return cell
    }
    
    
}
