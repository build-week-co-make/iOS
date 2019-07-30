//
//  CreateIssueViewController.swift
//  Co-Make
//
//  Created by Alex Shillingford on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class CreateIssueViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var takePhotoButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    
    
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pickerController.sourceType = UIImagePickerController.SourceType.camera
        pickerController.delegate = self
    }
    

    @IBAction func takePhotoButtonTapped(_ sender: UIButton) {
        present(pickerController, animated: true, completion: nil)
    }
    
}

extension CreateIssueViewController: UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("The camera has been closed")
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        issueImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
}

extension CreateIssueViewController: UINavigationControllerDelegate {
    
}
