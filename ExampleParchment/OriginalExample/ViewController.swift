import UIKit
import Parchment

// This is the simplest use case of using Parchment. We just create a
// bunch of view controllers, and pass them into our paging view
// controller. FixedPagingViewController is a subclass of
// PagingViewController that makes it much easier to get started with
// Parchment when you only have a fixed array of view controllers. It
// will create a data source for us and set up the paging items to
// display the view controllers title.

class ViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let firstViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
    let secondViewController = storyboard.instantiateViewController(withIdentifier: "CameraViewController")
    let thirdViewController = storyboard.instantiateViewController(withIdentifier: "InfoViewController")
    let fourthViewController = storyboard.instantiateViewController(withIdentifier: "StarViewController")

    
    // Initialize a FixedPagingViewController and pass
    // in the view controllers.
//
//    let firstViewController = HomeVC()
//    let secondViewController = CameraPageVC()
//    let thirdViewController = InfoVC()
//    let fourthViewController = StarVC()

    let pagingViewController = FixedPagingViewController(viewControllers: [
        firstViewController,
        secondViewController,
        thirdViewController,
        fourthViewController,
        ])
//    pagingViewController.menuItemClass = IconPagingCell.self
    pagingViewController.menuItemSize = .fixed(width: view.frame.width/4, height: 60)
    pagingViewController.textColor = #colorLiteral(red: 1, green: 0.5133574329, blue: 0, alpha: 1)
        //UIColor(red: 0.51, green: 0.54, blue: 0.56, alpha: 1)
    pagingViewController.selectedTextColor = #colorLiteral(red: 0, green: 0.6002358198, blue: 0.9933881164, alpha: 1)
        //UIColor(red: 0.14, green: 0.77, blue: 0.85, alpha: 1)
    pagingViewController.indicatorColor = #colorLiteral(red: 0, green: 0.6002358198, blue: 0.9933881164, alpha: 1)
        //UIColor(red: 0.14, green: 0.77, blue: 0.85, alpha: 1)
    
//    let viewControllers = (0...10).map { IndexViewController(index: $0) }
//    let pagingViewController = FixedPagingViewController(viewControllers: viewControllers)
    
//     Make sure you add the PagingViewController as a child view
//     controller and constrain it to the edges of the view.
    addChildViewController(pagingViewController)
    view.addSubview(pagingViewController.view)
    view.constrainToEdges(pagingViewController.view)
    pagingViewController.didMove(toParentViewController: self)
  }
}


