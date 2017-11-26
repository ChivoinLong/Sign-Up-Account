//
//  ResultViewController.swift
//  Sign Up Account
//
//  Created by Obi-Voin Kenobi on 11/24/17.
//  Copyright © 2017 Obi-Voin Kenobi. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    private var username: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text! += (username!.uppercased() + ", your account has been succeccfully created.")
    }
    
    public func setUsername(username: String?) {
        self.username = username
    }
    
    @IBAction func didPressGoBackButton(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToSignUpViewController", sender: self)
    }
    
}
