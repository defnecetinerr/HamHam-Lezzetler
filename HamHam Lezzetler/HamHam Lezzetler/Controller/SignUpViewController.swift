//
//  SignUpViewController.swift
//  HamHam Lezzetler
//
//  Created by Defne Çetiner on 22.04.2023.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var surnameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var firstPasswordText: UITextField!
    @IBOutlet weak var secondPasswordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    @IBAction func goBackButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func signUpTappedAction(_ sender: Any) {
        guard let name = nameText.text, !name.isEmpty else {
            makeAlert(titleInput: "Error!", messageInput: "Name cannot be empty")
            return
        }
        
        guard let surname = surnameText.text, !surname.isEmpty else {
            makeAlert(titleInput: "Error!", messageInput: "Surname cannot be empty")
            return
        }
        
        guard let email = emailText.text, !email.isEmpty else {
            makeAlert(titleInput: "Error!", messageInput: "Email cannot be empty")
            return
        }
        
        guard let password = firstPasswordText.text, !password.isEmpty else {
            makeAlert(titleInput: "Error!", messageInput: "Password cannot be empty")
            return
        }
        
        guard let confirmPassword = secondPasswordText.text, !confirmPassword.isEmpty else {
            makeAlert(titleInput: "Error!", messageInput: "Confirm Password cannot be empty")
            return
        }
        
        if password != confirmPassword {
            makeAlert(titleInput: "Error!", messageInput: "Passwords do not match")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authdata, error) in
            if let error = error {
                self.makeAlert(titleInput: "Error!", messageInput: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "goSign", sender: nil)
            }
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
           let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
           let action = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(action)
           present(alert, animated: true, completion: nil)
       }
}
