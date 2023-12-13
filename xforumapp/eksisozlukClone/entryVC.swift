import UIKit
import Firebase

class EntryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var entryArray = [String]()
    var selectedSubject: String?
    
    //@IBOutlet weak var entryLabel: UILabel!
    
    //@IBOutlet weak var entryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Eklenen kod: Verileri çek
        getDataFromFirestore()
        
        // Eklenen kod: Konu başlığını göster
       // entryLabel.text = selectedSubject
    }
    
    // Eklenen kod: Firestore'dan veri çekme fonksiyonu
    func getDataFromFirestore() {
        let fireStoreDatabase = Firestore.firestore()
        
        fireStoreDatabase.collection("Subjects")
            .whereField("subject", isEqualTo: selectedSubject ?? "")
            .addSnapshotListener { snapshot, error in
                if error == nil {
                    if snapshot?.isEmpty != true && snapshot != nil {
                        // Eklenen kod: Diziyi temizle
                        self.entryArray.removeAll()
                        
                        for document in snapshot!.documents {
                            if let entry = document.get("entry") as? String {
                                // Eklenen kod: Entry'yi diziye ekle
                                self.entryArray.append(entry)
                            }
                        }
                        
                        // Eklenen kod: TableView'ı güncelle
                       // self.entryTableView.reloadData()
                    }
                }
        }
    }
    
    // Eklenen kod: TableView datasource metodları
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = entryArray[indexPath.row]
        return cell
    }
    
    
}
