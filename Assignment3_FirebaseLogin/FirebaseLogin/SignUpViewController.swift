//
//  SignUpViewController.swift
//  FirebaseLogin
//
//  Created by Valentina Song on 11/9/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController
{

    @IBOutlet weak var lblEmail: UITextField!
    
    @IBOutlet weak var lblPassword: UITextField!
    
    @IBOutlet weak var lblRepeatPassword: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SignUpAction(_ sender: Any)
    {
        let email = lblEmail.text
        let password = lblPassword.text
        let repeatPassword = lblRepeatPassword.text
        
        if email?.isEmail == false
        {
            let reEnterEmailAlert = UIAlertController(title: "Email is invalid", message: "Please enter a valid email address", preferredStyle: .alert)
            reEnterEmailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(reEnterEmailAlert, animated: true, completion: nil)
            return
        }
        else if repeatPassword != password
        {
            let reEnterPasswordAlert = UIAlertController(title: "Password does not match", message: "Please enter the correct password", preferredStyle: .alert)
            reEnterPasswordAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(reEnterPasswordAlert, animated: true, completion: nil)
            return
        }
        else
        {
            Auth.auth().createUser(withEmail: email!, password: password!, completion:
                {
                (AuthDataResult, error) in
                if error != nil
                {
                    let signupFailedAlert = UIAlertController(title: "Sign up Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    signupFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(signupFailedAlert, animated: true, completion: nil)
                }
                else
                {
                    let createUserAlert = UIAlertController(title: "New Account created successfully", message: "Check and confirm your email", preferredStyle: .alert)
                    createUserAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(createUserAlert, animated: true, completion: nil)
                }
            })
        }
    }
}
