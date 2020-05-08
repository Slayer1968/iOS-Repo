import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var theText = "Write here..."
    var textArray = [String]() // we initialize an empty String array
    var currentRowToEdit = -1 // -1 means no editing
    let fileName = "theString.txt"
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() { // will only get called the very first time the app is launched
        super.viewDidLoad()
        textArray.append("Hello")
        textArray.append("How are you?")
        tableView.dataSource = self
        tableView.delegate = self
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = theText
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        theText = textView.text
        if currentRowToEdit > -1 {
            textArray[currentRowToEdit] = theText
            currentRowToEdit = -1
        } else {
            textArray.append(theText) // add the new text to the array
        }
        tableView.reloadData()
        textView.text = ""
        saveStringToFile(str: theText, fileName: fileName)
        print(readStringFromFile(fileName: fileName))
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
     }
     
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell1"){
        cell.textLabel?.text = textArray[indexPath.row]
            return cell
        }else {
            return UITableViewCell()
        }
     }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("you clicked \(indexPath.row)")
        currentRowToEdit = indexPath.row
        textView.text = textArray[currentRowToEdit]
    }
    
    
    func saveStringToFile(str:String, fileName:String){
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do {
            try str.write(to: filePath, atomically: true, encoding: .utf8)
            print("OK writing string \(str)")
        }catch {
            print("error writing string \(str)")
        }
    }
    
    
    func readStringFromFile(fileName:String) -> String {
        let filePath = getDocumentDir().appendingPathComponent(fileName)
        do {
            let string = try String(contentsOf: filePath, encoding: .utf8)
            return string
        } catch  {
            print("error while reading file " + fileName)
        }
        return "empty"
    }
    
    
    func getDocumentDir() -> URL {
        let documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentDir[0]
    }
}
