import UIKit
import CoreMotion

class ViewController: UIViewController {

    
    var motionManager = CMMotionManager() //will handle sensor data
    var queue = OperationQueue() //will act as a buffer for sensor data
    
    
    @IBOutlet weak var amountField: UITextField!
    @IBOutlet weak var phNumField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusLabel.isHidden = true //make extra sure the label is hidden
    }


    @IBAction func goToPaymentBtn(_ sender: UIButton) {
        motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in
            
            DispatchQueue.main.async {
                self.slider.value = Float((motion?.attitude.roll ?? 0) * 1.4)
                if self.slider.value == 1.0 {
                    self.statusLabel.isHidden = false //show the green label
                    self.motionManager.stopDeviceMotionUpdates() //save battery
                    self.slider.isHidden = true
                }
            }
        }
    }
}

