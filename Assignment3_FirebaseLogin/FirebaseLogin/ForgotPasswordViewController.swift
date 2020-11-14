//
//  ForgotPasswordViewController.swift
//  FirebaseLogin
//
//  Created by Valentina Song on 11/9/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import Firebase
class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var lblEmail: UITextField!
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    @IBAction func ResetAction(_ sender: Any)
    {
        let email = lblEmail.text
        if email?.isEmail == true
        {
            Auth.auth().sendPasswordReset(withEmail: email!, completion:
                {(error) in
    
                if error != nil
                {
                    let resetFailedAlert = UIAlertController(title: "Reset Failed", message: "Error: \(String(describing: error?.localizedDescription))", preferredStyle: .alert)
                    resetFailedAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetFailedAlert, animated: true, completion: nil)
                }
                else
                {
                    let resetEmailSentAlert = UIAlertController(title: "Reset email sent successfully", message: "Check your email", preferredStyle: .alert)
                    resetEmailSentAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(resetEmailSentAlert, animated: true, completion: nil)
                }
            })
        }
        else
        {
            let reEnterEmailAlert = UIAlertController(title: "Email is invalid", message: "Please enter a valid email address", preferredStyle: .alert)
            reEnterEmailAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(reEnterEmailAlert, animated: true, completion: nil)
        }
    }
}
