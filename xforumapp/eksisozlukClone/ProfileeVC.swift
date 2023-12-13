//
//  ProfileeVC.swift
//  eksisozlukClone
//
//  Created by Olgun ‏‏‎‏‏‎ on 12.11.2023.
//

import UIKit
import Firebase
class ProfileeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func profileSignOutClicked(_ sender: Any) {
        /*
         do {
         try Auth.auth().signOut()
         
         self.performSegue(withIdentifier: "toViewController", sender: nil)
         }
         catch {
         }
         
         }
         
         */
        self.performSegue(withIdentifier: "toViewController", sender: nil)
    }
}
