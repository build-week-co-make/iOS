//
//  CreateIssueViewController.swift
//  Co-Make
//
//  Created by Alex Shillingford on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import CoreData

class CreateIssueViewController: UIViewController, NSFetchedResultsControllerDelegate {
    //MARK: - IBOutlets and Properties
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var issueImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    var apiController: ApiController?
    
    var fetchedResultsController: NSFetchedResultsController<User>?
    
    var stringImage: String = ""
    let pickerController = UIImagePickerController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.layer.cornerRadius = 5.0
//        pickerController.sourceType = UIImagePickerController.SourceType.camera
//        pickerController.delegate = self
    }
    
    // MARK: - IBActions and Methods
//    @IBAction func takePhotoButtonTapped(_ sender: UIImageView) {
//        present(pickerController, animated: true, completion: nil)
//    }

    @IBAction func postIssueButtonTapped(_ sender: UIButton) {
        
        guard let user = fetchedResultsController?.fetchedObjects?[0],
            let zipCode = zipCodeTextField.text,
            let issueName = titleTextField.text,
            let description = descriptionTextView.text else { return }
        
        apiController?.createIssue(userID: Int(user.userID), zipCode: Int(zipCode) ?? Int(user.zipCode), issueName: issueName, description: description, category: "Environment", picture: nil)
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
//    func convertZIPCodeToInt() -> Int {
//        if let zipCodeString = zipCodeTextField.text {
//            if !zipCodeString.isEmpty {
//
//            }
//        }
//    }
    
    func convertToBase64(image: UIImage) -> String {
        return image.pngData()!.base64EncodedString()
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
        stringImage = convertToBase64(image: issueImageView.image!)
    }
}

//extension CreateIssueViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        //if the text isn't empty, only then can this method return to the next one.
//        if let text = textField.text, !text.isEmpty {
//            switch textField {
//            case titleTextField:
//                titleTextField.resignFirstResponder()
//            case zipCodeTextField:
//                zipCodeTextField.resignFirstResponder()
//            default:
//                textField.resignFirstResponder()
//            }
//
//        }
//        return false
//    }
//}

extension CreateIssueViewController: UINavigationControllerDelegate {
    
}
