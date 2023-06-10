//
//  ViewController.swift
//  HamHam Lezzetler
//
//  Created by Defne Çetiner on 22.04.2023.
//

import UIKit
import Firebase

class SignViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var rememberSwitch: UISwitch!
    @IBOutlet weak var passwordLabel: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func rememberSwitchAction(_ sender: Any) {
        UserDefaults.standard.set(rememberSwitch.isOn, forKey: "RememberUser")

    }
    
    @IBAction func signInTapped(_ sender: Any) {
        guard let email = emailLabel.text, !email.isEmpty else {
            makeAlert(titleInput: "Hata", messageInput: "E-posta boş olamaz")
            return
        }
        
        guard let password = passwordLabel.text, !password.isEmpty else {
            makeAlert(titleInput: "Hata", messageInput: "Şifre boş olamaz")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                self.makeAlert(titleInput: "Hata", messageInput: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "goGomePage", sender: nil)
            }
        }
    }
    
    @IBAction func signUptapped(_ sender: Any) {
        
        self.performSegue(withIdentifier: "goSignUpPage", sender: nil)
    }
    
    func makeAlert(titleInput:String, messageInput:String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}

