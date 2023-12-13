import UIKit
import Firebase
import FirebaseStorage

class SearchVC: UIViewController {
    
    @IBOutlet weak var konuText: UITextField!
    @IBOutlet weak var entryTest: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gerekirse, view yüklendiğinde yapılması gereken ek işlemleri buraya ekleyebilirsiniz.
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        // Adım 1: Metin değerlerini alın
        
        
        
        if let konu = konuText.text, let entry = entryTest.text {
            
            
            if let tabBarController = self.tabBarController {
                tabBarController.selectedIndex = 0
               
      
                               }
            else {
                print("Error")
                return
            }
            
            
            // Adım 2: Firebase Storage'a bir referans oluşturun
            let storage = Storage.storage()
            let storageReference = storage.reference()
            let mediaFolder = storageReference.child("Entrys")
            
            // Adım 3: Metni Veri'ye dönüştürün (uygun bir kodlamayı seçebilirsiniz)
            if let data = konu.data(using: .utf8) {
                // Adım 4: Veriyi Firebase Storage'a yükleyin
                let uuid = UUID().uuidString
                let konuReference = mediaFolder.child("\(uuid).txt")
                konuReference.putData(data, metadata: nil) { (metadata, error) in
                    if let error = error {
                        print("Error: \(error.localizedDescription)")
                    }
                    else {
                        print("Succesfull!")
                        // Başarı durumunu burada işleyebilirsiniz, örneğin bir başarı mesajı gösterme
                    }
                }
            } else {
                print("Convert Error!")
            }
            let firestoreDatabase = Firestore.firestore()
            var firestoreReference : DocumentReference? = nil
            let firestorePost = ["postedBy" : Auth.auth().currentUser?.email,"entry" : self.entryTest.text!, "subject" : self.konuText.text!, "date" : FieldValue.serverTimestamp() ] as [String : Any]
            firestoreReference = firestoreDatabase.collection("Subjects").addDocument(data: firestorePost ,completion: { (error) in
                if error != nil {
                    print("Error")
                }
                
                
                
                
            })
            
        }
    }
}
