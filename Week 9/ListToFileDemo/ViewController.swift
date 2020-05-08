import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let fromFileArr = Storage.read()
        print(fromFileArr) //if this works, then the file was read
        Storage.addItem(str: "hello2")
        print(fromFileArr)
    }


}

