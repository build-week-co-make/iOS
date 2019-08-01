//
//  IssueTableViewCell.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class IssueTableViewCell: UITableViewCell {

    
    @IBOutlet var issueImage: UIImageView!
    
    @IBOutlet var issueTitle: UILabel!
    @IBOutlet var issueCreator: UILabel!

    @IBOutlet var numberOfUpVotes: UILabel!
    
    @IBOutlet var firstFIlterType: UILabel!
    
    @IBOutlet var secondFilterType: UILabel!
    
    var issue: Issue? {
        didSet {
            updateViews()
        }
    }

    
    ///put all logic related to the cell in a computed property of type issue, in the didSet property
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //put all styling in here
    }


    func updateViews() {
        
        guard let issue = issue else { return }
        
        
        issueImage.image = issue.picture?.toImage()
        issueTitle.text = issue.issueName
        issueCreator.text = "\(issue.userID)"
        //        numberOfUpVotes.text = issue
        firstFIlterType.text = issue.category
    
    }

   

}
    
    extension String {
        func toImage() -> UIImage? {
            if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
                return UIImage(data: data)
            }
            return nil
        }
    }

