//
//  LoginViewController.swift
//  firebaseApp
//
//  Created by Mix174 on 02.09.2021.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleTextField(emailLabel)
        Utilities.styleTextField(passwordLabel)
    }
    

    @IBAction func signUpTapped(_ sender: Any) {
        
        guard let email = emailLabel.text?
                .trimmingCharacters(in: .whitespacesAndNewlines),
              let password = passwordLabel.text?
                .trimmingCharacters(in: .whitespacesAndNewlines) else {
            print("error with email&password binding")
            return
        }
        Auth.auth().signIn(withEmail: email,
                           password: password) { [weak self] (result, error) in
        
            if let error = error {
                print(error.localizedDescription)
            } else {
                self?.signIn()
            }
        }
    }
    
    func signIn() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
