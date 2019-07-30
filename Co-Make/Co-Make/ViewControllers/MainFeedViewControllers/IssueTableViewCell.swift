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

    
    ///put all logic related to the cell in a computed property of type issue, in the didSet property
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //put all styling in here
    }




}
