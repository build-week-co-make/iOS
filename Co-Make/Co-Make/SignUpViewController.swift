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
    
    var name: String = ""
    var email: String = ""
    var password: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddLocation" {
            guard let allowLocationVC = segue.destination as? AllowLocationViewController else { return }
            allowLocationVC.name = self.name
            allowLocationVC.email = self.email
            allowLocationVC.password = self.password
        }
     }
    
    

    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        if let name = nameTextField.text, !name.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty {
            self.name = name
            self.email = email
            self.password = password
            performSegue(withIdentifier: "AddLocation", sender: self)
        }
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
