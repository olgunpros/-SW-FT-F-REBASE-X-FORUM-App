import UIKit
import Firebase
import GoogleMobileAds

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, GADBannerViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var bannerView: GADBannerView!
    var userEmailArray = [String]()
    var subjectArray = [String]()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let adSize = GADAdSizeFromCGSize(CGSize(width: 900, height: 100))

        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "testID"
          bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

            addBannerViewToView(bannerView)
          }

          func addBannerViewToView(_ bannerView: GADBannerView) {
            bannerView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bannerView)
            view.addConstraints(
              [NSLayoutConstraint(item: bannerView,
                                  attribute: .bottom,
                                  relatedBy: .equal,
                                  toItem: view.safeAreaLayoutGuide,
                                  attribute: .bottom,
                                  multiplier: 1,
                                  constant: 0),
               NSLayoutConstraint(item: bannerView,
                                  attribute: .centerX,
                                  relatedBy: .equal,
                                  toItem: view,
                                  attribute: .centerX,
                                  multiplier: 1,
                                  constant: 0)
              ])
              

              
        
        getDataFromFirestore()
    }

    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Subjects").addSnapshotListener { snapshot, error in
            if error == nil {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userEmailArray.removeAll()
                    self.subjectArray.removeAll()
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let subject = document.get("subject") as? String {
                            self.subjectArray.append(subject)
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? FeedCell
        cell!.subjectLabel.text = subjectArray[indexPath.row]
        return cell!
    }
    
    @IBAction func entryVieww(_ sender: Any) {
        self.performSegue(withIdentifier: "toEntryVC", sender: nil)
    }
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("bannerViewDidDismissScreen")
    }
    
    }
    


    

