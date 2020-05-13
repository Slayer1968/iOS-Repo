import UIKit

class SecondVC: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var theText = "You are a bold one."
    var textArray = [String]() // initialize an empty String array
    var currentRowToEdit = -1 // -1 means no editing
    
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textArray.append("Hello there.")
        textArray.append("General Kenobi!")
        tableView.dataSource = self
        tableView.delegate = self
    }
  
    
    override func viewWillAppear(_ animated: Bool) {
        textView.text = theText
    }
    
    
    @IBAction func savePressed(_ sender: UIButton) {
        theText = textView.text!
        if currentRowToEdit > -1 {
            textArray[currentRowToEdit] = theText
            currentRowToEdit = -1
        } else {
            textArray.append(theText) // add the new text to the array
        }
        tableView.reloadData()
        textView.text = ""
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
}

