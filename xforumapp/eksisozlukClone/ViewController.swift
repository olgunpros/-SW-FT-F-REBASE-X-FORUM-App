//
//  ViewController.swift
//  eksisozlukClone
//
//  Created by Olgun ‏‏‎‏‏‎ on 12.11.2023.
//

import UIKit
import GoogleMobileAds
import Firebase
class ViewController: UIViewController, GADFullScreenContentDelegate {
    private var interstitial: GADInterstitialAd?
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    func makeAlert (title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = GADRequest()
            GADInterstitialAd.load(withAdUnitID: "testID",
                                        request: request,
                              completionHandler: { [self] ad, error in
                                if let error = error {
                                  print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                  return
                                }
                                interstitial = ad
                interstitial?.fullScreenContentDelegate = self
                              }
            )
        
        // Do any additional setup after loading the view.
    }
    @IBAction func signInClicked(_ sender: Any) {
        
        
        
       /* if mailText.text != "" && passwordText.text != "" {
            
            Auth.auth().signIn(withEmail: mailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
                
                
            }
            if interstitial != nil {
                interstitial?.present(fromRootViewController: self)
              } else {
                print("Ad wasn't ready")
              }
        } */
        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
    @IBAction func signUpClicked(_ sender: Any) {
       /* if mailText.text != "" && passwordText.text != "" {
            Auth.auth().createUser(withEmail: mailText.text!, password: passwordText.text!) { (authdata, error) in
                if error != nil {
                    self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                }
                else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)


                }
        }
       
        }
        else {
            self.makeAlert(title: "Hata",message: "Mail ve parola gir")


        }
        */
        
        self.performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    /// Tells the delegate that the ad failed to present full screen content.
        
      func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
      }

      /// Tells the delegate that the ad will present full screen content.
      func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad will present full screen content.")
      }

      /// Tells the delegate that the ad dismissed full screen content.
      func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
      }
    }
    


