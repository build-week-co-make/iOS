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
    var fetchedResultsController: NSFetchedResultsController<User>?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        
        feedTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for:.selected)
        
        
        searchIssues.cornerRadius = 20
        userImage.image = UIImage(named: "sign-in-4")
        userImage.cornerRadius = 23
        
    }
    
  
    override func viewWillLayoutSubviews() {
        guard !(fetchedResultsController?.fetchedObjects?.isEmpty ?? true) else {
            showSignupModally()
            return }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        issuesTableView.reloadData()
    
        guard !(fetchedResultsController?.fetchedObjects?.isEmpty ?? true) else {
            
            return }
        guard let user = fetchedResultsController?.fetchedObjects?[0],
            let apiController = apiController,
            let email = user.email,
            let password = user.password else {
                showSignupModally()
                return }
        if Bearer.shared == nil {
            apiController.signIn(with: email, password: password, completion: {_ in
                apiController.fetchIssuesFromServer(completion: { (_) in
                    DispatchQueue.main.async {
                        self.displayUserInfo()
                        self.issuesTableView.reloadData()
                    }
                })
            })
        }
    }
    
    func showSignupModally() {
        let pagesVC = PageViewController()
        pagesVC.modalPresentationStyle = .fullScreen
        present(pagesVC, animated: true, completion: nil)
    }
    
    
    func displayUserInfo() {
        guard let user = fetchedResultsController?.fetchedObjects?[0] else { return }
        userActualName.text = user.username
        userAddress.text = String(user.zipCode)
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
        
        return apiController?.issues.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = issuesTableView.dequeueReusableCell(withIdentifier: "IssueCell", for: indexPath) as? IssueTableViewCell else {return UITableViewCell()}
        
        let selectedIssue = apiController?.issues[indexPath.row]
        
        cell.issue = selectedIssue
        
        return cell
    }
    
    
}
