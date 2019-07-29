//
//  FeedViewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    @IBOutlet var userImage: UIImageView!
    
    @IBOutlet var userActualName: UILabel!
    
    @IBOutlet var userAddress: UILabel!
    
    @IBOutlet var issuesTableView: UITableView!
    
    @IBOutlet var searchIssues: UISearchBar!
    
    let sampleData = ["sampledata"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchIssues.cornerRadius = 20
        userImage.image = UIImage(named: "sign-in-4")
        userImage.cornerRadius = 23
        
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
