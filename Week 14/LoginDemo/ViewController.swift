import UIKit
import FirebaseAuth
import FacebookLogin
import FacebookCore

class ViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    var firebaseManager:FirebaseManager?
    var facebookManager:FacebookManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager = FirebaseManager(parentVC: self) // enable firebaseManager to update GUI
        facebookManager = FacebookManager(parentVC: self)
    }
    
    func presentSecretVC() {
        performSegue(withIdentifier: "secretSegue1", sender: self)
    }
    
    func presentVC() {
        performSegue(withIdentifier: "secretSegue2", sender: self)
    }
    
    @IBAction func signupBtnPressed(_ sender: UIButton) {
        if verify().isOK {
            firebaseManager?.signUp(email: verify().email, pwd: verify().pwd)
        }
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
        // warning: Do not hide content based on this call. Do that in the addIDTokenDidChangeListener
        firebaseManager?.signOut()
    }
    
    @IBAction func signInPressed(_ sender: UIButton) {
        if verify().isOK {
            firebaseManager?.signIn(email: verify().email, pwd: verify().pwd)
            presentSecretVC() //call segue
        }
    }
    
    @IBAction func facebookLoginPressed(_ sender: UIButton) {
        facebookManager?.loginToFacebook()
        presentVC() //call second segue
    }
    
    // make Graph request for user data
    // In similar way, you can get user news feed
    @IBAction func loadFaceBookDataPressed(_ sender: UIButton) {
        facebookManager?.makeGraphRequest()
    }
    
    func verify() -> (email:String, pwd:String, isOK:Bool) {  // returning multiple values is called "tuple"
        if let email = emailField.text, let pwd = passwordField.text { // check if there is enough text
                          if email.count > 5 && pwd.count > 5{
                            return (email, pwd, true); // a tuple, containing 3 values
                          }
               }
        return ("", "", false)  // a tuple, containing 3 values
    }

}
