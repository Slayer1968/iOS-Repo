import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    var pedometer = CMPedometer()
    
    @IBOutlet weak var stepsLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
 
    @IBOutlet weak var averagePaceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func startBtn(_ sender: UIButton) {
        pedometer = CMPedometer()
        pedometer.startUpdates(from: Date()) { (data, error) in
            DispatchQueue.main.async {
                if(error == nil) {
                    self.stepsLabel.text = data?.numberOfSteps.stringValue
                    self.distanceLabel.text = data?.distance?.stringValue
                    self.averagePaceLabel.text = data?.averageActivePace?.stringValue
                }
            }
        }
    }
    
    
    @IBAction func stopBtn(_ sender: UIButton) {
        pedometer.stopUpdates()
    }
    
}

