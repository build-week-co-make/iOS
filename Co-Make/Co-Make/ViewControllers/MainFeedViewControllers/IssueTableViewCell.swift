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
        
        guard let issue = issue,
            let image = issue.picture else { return }
        
        
//        issueImage.image = image.toImage()
        issueImage.downloaded(from: image)
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


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
