import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    var images = [String] ()
    
    @IBOutlet weak var headline: UITextView!
    
    @IBOutlet weak var body: UITextView!
    
    var rowNumber = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let note = CloudStorage.getNoteAt(index: rowNumber)
        headline.text = note.head
        body.text = note.body
        if note.image != "empty" {
            
            CloudStorage.downloadImage(name: note.image, vc: self)
        }
        /*
        images.append("unnamed (1).jpg")
        images.append("unnamed.jpg")
        images.append("Syndicate.jpg")
        images.append("Karma Second Act main art.jpg")
        images.append("wallpaper.jpg")        
        
        //CloudStorage.deleteNote(id: "g5TGJoYbcWaLREyIofIJ") would call the deleteNote method in Storage
        */
 }

    
    @IBAction func saveBtnPressed(_ sender: UIButton) {
        CloudStorage.updateNote(index: 0, head: "new headline1", body: "new body1")
    }
    
    
    @IBAction func downloadBtnPressed(_ sender: UIButton) {
        CloudStorage.downloadImage(name: images.randomElement()!, vc:self)
        // calls static method and prints a message
        
    }
    
}
