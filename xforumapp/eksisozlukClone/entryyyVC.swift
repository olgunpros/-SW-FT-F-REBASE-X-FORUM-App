
import UIKit
import Firebase
class entryyyVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    
    @IBOutlet weak var yeniTableView: UITableView!
    var entryArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        yeniTableView.delegate = self
        yeniTableView.dataSource = self
      getDataFromFirestore()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Subjects").addSnapshotListener { snapshot, error in
            if error == nil {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.entryArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        
                        if let entry = document.get("entry") as? String {
                            self.entryArray.append(entry)
                        }
                    }
                    self.yeniTableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func backbuttonClicked(_ sender: Any) {
        
        self.performSegue(withIdentifier: "toHomeVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celll = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as? yeniCell
        celll!.entryLabel.text! = entryArray[indexPath.row]
        
        return celll!
    }
    
    
    
        
        
    }
    


