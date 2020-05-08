import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self //we handle events for the tableview
        tableView.dataSource = self
        CloudStorage.startListener(tableView: tableView)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    //to make a new blank note
    @IBAction func addPressed(_ sender: UIButton) {
        CloudStorage.addNote(index: 0, head: "blank", body: "blank")
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CloudStorage.getSize()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
        cell?.textLabel?.text = CloudStorage.getNoteAt(index: indexPath.row).head
        return cell!
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ViewController {
            destination.rowNumber = tableView.indexPathForSelectedRow!.row
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("selected row number \(indexPath.row)")
        performSegue(withIdentifier: "segue1", sender: self)
    }

}
