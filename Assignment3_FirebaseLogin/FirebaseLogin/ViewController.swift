//
//  ViewController.swift
//  FirebaseLogin
//
//  Created by Valentina Song on 11/6/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import UIKit
import Firebase
import SwiftSpinner

class ViewController: UIViewController
{

    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginAction(_ sender: Any)
    {
        let email = txtEmail.text
        let password = txtPassword.text
        
        if email == "" || password!.count < 6
        {
            lblStatus.text = "Please enter email and correct password"
            return
        }
        if email?.isEmail == false
        {
            lblStatus.text = "Please enter valid email"
            return
        }
        
        SwiftSpinner.show("Logging in...")
        
        Auth.auth().signIn(withEmail: email!, password: password!) { [weak self] authResult, error in
            SwiftSpinner.hide()
            guard let strongSelf = self else { return }
            
            if error != nil
            {
                /*let ErrorAlert = UIAlertController(title: "Error:", message: error?.localizedDescription, preferredStyle: .alert)
                ErrorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self!.present(ErrorAlert, animated: true, completion: nil)
                self?.txtPassword.text = ""*/
                strongSelf.lblStatus.text = error?.localizedDescription
                return
            }
            
            self?.txtPassword.text = ""
            
            // I have successfully logged in  go to Dashboard
            self!.performSegue(withIdentifier: "loginSegue", sender: strongSelf)
            
        }
    }
    
    @IBAction func forgotPassword(_ sender: Any)
    {
        let forgotPasswordAlert = UIAlertController(title: "Forgot Password?", message: "", preferredStyle: .alert)
        
        forgotPasswordAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        forgotPasswordAlert.addAction(UIAlertAction(title: "Reset Password", style: .default, handler:
            {
            (action) in
            // go to the reset password page
            self.performSegue(withIdentifier: "forgotpassword", sender: self)
        }))
        
        self.present(forgotPasswordAlert, animated: true, completion: nil)
    }
    
    @IBAction func signup(_ sender: Any)
    {
        let signupAlert = UIAlertController(title: "Sign up to create a new account?", message: "", preferredStyle: .alert)
        
        signupAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        signupAlert.addAction(UIAlertAction(title: "Sign up", style: .default, handler:
            {
            (action) in
            // go to the sign up page
            self.performSegue(withIdentifier: "signup", sender: self)
        }))
        
        self.present(signupAlert, animated: true, completion: nil)
    }
}

