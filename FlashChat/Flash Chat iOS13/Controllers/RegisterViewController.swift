//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email=emailTextfield.text , let password = passwordTextfield.text{ //if for optional binding
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                print(e.localizedDescription)
            }
            else {
                //Navigate to ChatViewController through segue that is created in the storyboard
                self.performSegue(withIdentifier: K.registerSegue, sender: self)
            }
            }
        }
    }
    
}

