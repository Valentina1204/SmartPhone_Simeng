//
//  DashboardViewController.swift
//  FirebaseLogin
//
//  Created by Valentina Song on 11/9/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import Firebase
class DashboardViewController: UIViewController {

    @IBOutlet weak var lblStatus: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutAction(_ sender: Any)
    {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popViewController(animated: true)
        }
        catch let signOutError as NSError
        {
          print ("Error signing out: %@", signOutError)
            lblStatus.text = signOutError.localizedDescription
        }
    }
    
}
