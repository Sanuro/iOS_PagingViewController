

import UIKit

class InfoVC: UIViewController{

    @IBAction func infoVCSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "InfoSegue", sender: self)
        
    }
    
    @IBAction func unwindSegueInfoVC(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        view.backgroundColor = UIColor.blue
    }

    
    

}
