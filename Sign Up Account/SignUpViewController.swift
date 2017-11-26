//
//  ViewController.swift
//  Sign Up Account
//
//  Created by Obi-Voin Kenobi on 11/24/17.
//  Copyright © 2017 Obi-Voin Kenobi. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var leftViewLabel: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeAppearance()
        setDelegates()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResultViewController" {
            
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            phoneNumberTextField.resignFirstResponder()
            emailTextField.resignFirstResponder()
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            guard isUsernameCorrect() else {
                alert.title = "Username is Incorrect"
                self.present(alert, animated: true, completion: { self.usernameTextField.becomeFirstResponder() })
                return
            }
            
            guard isPasswordCorrect() else {
                alert.title = "Password is Incorrect"
                self.present(alert, animated: true, completion: { self.passwordTextField.becomeFirstResponder() })
                return
            }
            
            guard isPhoneNumberCorrect() else {
                alert.title = "Phone Number is Incorrect"
                self.present(alert, animated: true, completion: { self.phoneNumberTextField.becomeFirstResponder() })
                return
            }
            
            guard isEmailCorrect() else {
                alert.title = "Email is Incorrect"
                self.present(alert, animated: true, completion: { self.emailTextField.becomeFirstResponder() })
                return
            }
            
            let resultVC = segue.destination as! ResultViewController
            resultVC.setUsername(username: usernameTextField.text)
        }
        
    }
    
    @IBAction func unwindToSignUpViewController(segue:UIStoryboardSegue) {
        usernameTextField.text = nil
        passwordTextField.text = nil
        phoneNumberTextField.text = nil
        emailTextField.text = nil
        
        setPhoneLeftView(isShow: false)
    }
    
    
    /* Functions */
    func setDelegates() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func customizeAppearance() {
        usernameTextField.borderStyle = .roundedRect
        passwordTextField.borderStyle = .roundedRect
        phoneNumberTextField.borderStyle = .roundedRect
        emailTextField.borderStyle = .roundedRect
        
        
        leftViewLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 65, height: 50))
        leftViewLabel?.text = "  (+855)"
        leftViewLabel?.font = UIFont(name: "Avenir Next", size: 18)
        phoneNumberTextField.addSubview(leftViewLabel!)
        phoneNumberTextField.leftView = leftViewLabel
    }
    
    func setPhoneLeftView(isShow: Bool) {
        if isShow {
            phoneNumberTextField.leftViewMode = .always
            phoneNumberTextField.placeholder = "000-000-0000"
        }
        else {
            phoneNumberTextField.leftViewMode = .never
            phoneNumberTextField.placeholder = "(+855) 000-000-0000"
        }
        
    }
    
    
    /* Validate Functions */
    
    func isUsernameCorrect() -> Bool {
        guard let username = usernameTextField.text else {
            return false
        }
        
        guard !(username.isEmpty) else {
            return false
        }
        
        return true
    }
    
    func isPasswordCorrect() -> Bool {
        guard let password = passwordTextField.text else {
            return false
        }
        
        guard !(password.isEmpty) else {
            return false
        }
        
        guard password.count >= 5 else {
            return false
        }
        
        return true
    }
    
    func isPhoneNumberCorrect() -> Bool {
        guard let phone = phoneNumberTextField.text else {
            return false
        }
        
        guard !(phone.isEmpty) else {
            return false
        }
        
        guard phone.count >= 11 else {
            return false
        }
        
        return true
    }
    
    func isEmailCorrect() -> Bool {
        guard let email = emailTextField.text else {
            return false
        }
        
        guard !(email.isEmpty) else {
            return false
        }
        
        guard email.isValidEmail() else {
            return false
        }
        
        return true
    }
}

/* Extensions */

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
            case usernameTextField:
                passwordTextField.becomeFirstResponder()
                return true
            
            case passwordTextField:
                phoneNumberTextField.becomeFirstResponder()
                return true
            
            case emailTextField:
                emailTextField.resignFirstResponder()
                return true
            
            default:
                return false
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == phoneNumberTextField {
            setPhoneLeftView(isShow: true)
        }
        return true
            
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
            case phoneNumberTextField:
                if phoneNumberTextField.text == nil || phoneNumberTextField.text == "" {
                    setPhoneLeftView(isShow: false)
                }
            
            default:
                return
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
            case phoneNumberTextField:
                let index = range.location
                
                if range.length == 0 {
                    if index == 3 || index == 7 {
                        textField.text!.append("-")
                    }
                    else if index == 12 {
                        emailTextField.becomeFirstResponder()
                        return false
                    }
                }
                else {
                    if index == 8 || index == 4 {
                        textField.text!.removeLast()
                    }
                }
                return true
            default:
                return true
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
    }
    
    
}
