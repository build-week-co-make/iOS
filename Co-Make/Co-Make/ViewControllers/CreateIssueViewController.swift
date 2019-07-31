//
//  CreateIssueViewController.swift
//  Co-Make
//
//  Created by Alex Shillingford on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class CreateIssueViewController: UIViewController {
    //MARK: - IBOutlets and Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
//    let apiController: ApiController? 
    let pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.cornerRadius = 5.0
        pickerController.sourceType = UIImagePickerController.SourceType.camera
        pickerController.delegate = self
    }
    
    //MARK: - IBActions and Methods
    @IBAction func takePhotoButtonTapped(_ sender: UIImageView) {
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func postIssueButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
}

//MARK: - Extensions
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
