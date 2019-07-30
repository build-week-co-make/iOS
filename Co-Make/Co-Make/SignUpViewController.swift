//
//  SignUpViewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/27/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var nameTextField: UITextField!
    
    @IBOutlet var bottomOfPasswordTextField: NSLayoutConstraint!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddLocation" {
//            let allowLocationVC = segue.destination as! AllowLocationViewController
//            allowLocationVC.user = user
        }
     }
    
    
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
   
    }
    
    
    
    @IBAction func faceBookButtonTapped(_ sender: UIButton) {
    }
    
    
}

extension SignUpViewController: UITextFieldDelegate {
    //this method is for returning to the next textifeld when the user presses return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //if the text isn't empty, only then can this method return to the next one.
        if let text = textField.text, !text.isEmpty {
            switch textField {
            case nameTextField:
                emailTextField.becomeFirstResponder()
            case emailTextField:
                passwordTextField.becomeFirstResponder()
            default:
                textField.resignFirstResponder()
            }
            
        }
        return false
    }
}
