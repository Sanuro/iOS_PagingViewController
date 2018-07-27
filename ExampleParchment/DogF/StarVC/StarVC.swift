//
//  StarVC.swift
//  dogfetchr
//
//  Created by Jaewon Lee on 7/25/18.
//  Copyright © 2018 SJJ. All rights reserved.
//

import UIKit

class StarVC: UIViewController {

    var tableData = ["Test1", "test2", "test3"]
    @IBAction func starUpGest(_ sender: UISwipeGestureRecognizer) {
        
    }
    
    @IBAction func unwindSegueStarVC(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
//extension StarVC: UITableViewDelegate, UITableViewDataSource{
//    //delete trailing swipe
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {action, view, completionHandler in
//
//            self.context.delete(self.tableData[indexPath.row])
//            self.tableData.remove(at: indexPath.row)
//            self.appDelegate.saveContext()
//
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            completionHandler(true)
//        }
//
//        var actions = [deleteAction]
//        //edit
//        let note = tableData[indexPath.row]
//        if note.completed == false{
//            let editAction = UIContextualAction(style: .normal, title: "Edit") {action, view, completionHandler in
//
//                self.performSegue(withIdentifier: "addEditSegue", sender: indexPath)
//                completionHandler(true)
//            }
//            editAction.backgroundColor = UIColor.purple
//            actions.append(editAction)
//        }
//
//        return UISwipeActionsConfiguration(actions: actions)
//    }
//}
