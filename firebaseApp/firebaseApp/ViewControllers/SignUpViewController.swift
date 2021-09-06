//
//  SignUpViewController.swift
//  firebaseApp
//
//  Created by Mix174 on 02.09.2021.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var secondNameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("SignUpViewController viewDidLoad")
        setupView()
    }
    
    func setupView() {
        errorLabel.alpha = 0
        Utilities.styleTextField(nameLabel)
        Utilities.styleTextField(secondNameLabel)
        Utilities.styleTextField(emailLabel)
        Utilities.styleTextField(passwordLabel)
        Utilities.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        if nameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || secondNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        || passwordLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please enter all fields"
        }
        
        guard let cleanPassword = passwordLabel.text else {
            print("Trouble with cleanPassword")
            return "Trouble with cleanPassword"
        }
        
        if !Utilities.isPasswordValid(cleanPassword) {
            return "Password is invalid"
        }
        return nil
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        if let error = validateFields() {
            showError(error)
        } else {
            guard let firstName = nameLabel.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines),
                  let secondNmae = secondNameLabel.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines),
                  let email = emailLabel.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines),
                  let password = passwordLabel.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                  else {
                print("signUpTapped: smtg wrong with data binding")
                return
            }
            Auth.auth().createUser(withEmail: email, password: password) { [weak self] (result, error) in
                
                if let error = error {
                    print("error in createUser: \(error.localizedDescription)")
                    self?.showError("error with create User")
                } else {
                    
                    let db = Firestore.firestore()
                    
                    guard let uid = result?.user.uid else {
                        print("smtg wrong with user uid binding")
                        return
                    }
                    
                    let data: [String: String] = ["firstName": firstName, "secondName": secondNmae, "uid": uid]
                    
                    db.collection("users").addDocument(data: data) { [weak self] error in
                        print("Error at addDocument \(String(describing: error?.localizedDescription))")
                        self?.showError("error with saving name, second name")
                    }
                    self?.transitionToHomeVC()
                }
            }
        }
    }
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomeVC() {
        let homeVC = storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        view.window?.rootViewController = homeVC
        view.window?.makeKeyAndVisible()
    }
}
