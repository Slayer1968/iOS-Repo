import Foundation
import FirebaseFirestore
import FirebaseStorage

class CloudStorage {
    
    private static var list = [Note]()
    private static let db = Firestore.firestore()
    private static let storage = Storage.storage() // get the instance
    private static let notes = "notes"
    
    
    
    static func downloadImage(name:String, vc:ViewController) {
        let imgRef = storage.reference(withPath: name) // get "file handle"
        imgRef.getData(maxSize: 4000000) { (data, error) in
            if error == nil{
                print("Success downloading image!")
                let img = UIImage(data: data!)
                DispatchQueue.main.async { // prevent background thread from interrupting main thread handling user input
                        vc.imageView.image = img
                }
            } else {
                print("Some error downloading \(error.debugDescription)")
            }
        }
    }
    
    
    static func getSize() -> Int {
        return list.count
    }
    
    static func getNoteAt(index: Int) -> Note {
        return list[index]
    }
    
    
    
    //READ
    static func startListener(tableView: UITableView){
        print("Starting listener")
        db.collection(notes).addSnapshotListener { (snap, error) in
            if error == nil {
                self.list.removeAll() // clears the list
                for note in snap!.documents {
                    let map = note.data()
                    print(map)
                    let head = map["head"] as! String
                    let body = map["body"] as! String
                    let image = map["image"] as? String ?? "empty"
                    
                    let newNote = Note(id: note.documentID, head: head, body: body, img: image)
                    self.list.append(newNote)
                }
                DispatchQueue.main.async {
                    tableView.reloadData()
                }
            }
        }
    }
    
    
    
    //ADD
    static func addNote(index: Int, head: String, body: String){
        db.collection(notes).addDocument(data: ["body": "blank", "head": "blank"])
    }
    
    
    
    
    //UPDATE
    static func updateNote(index: Int, head: String, body: String) {
        let note = list[index]
        
        let docRef = db.collection(notes).document(note.id)
        var map = [String:String]()
        map["head"] = head
        map["body"] = body
        
        docRef.setData(map)
    }
    
    
    
    //DELETE
    static func deleteNote(id:String) {
        let docRef = db.collection(notes).document(id)
        docRef.delete()
    }
    
}
