import Foundation

class Note {
    var id: String
    var head: String
    var body: String
    var image: String
    
    init (id: String, head: String, body: String, img: String) {
        self.id = id
        self.head = head
        self.body = body
        self.image = img
    }
}
