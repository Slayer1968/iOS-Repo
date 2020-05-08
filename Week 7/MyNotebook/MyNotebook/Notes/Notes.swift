import Foundation

class Note {
    var id: String = ""
    var head: String = ""
    var body: String = ""
    
    init (id: String, head: String, body: String) {
        self.id = id
        self.head = head
        self.body = body
    }
}
