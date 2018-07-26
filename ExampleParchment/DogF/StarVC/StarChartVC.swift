//
//  StarChartVC.swift
//  dogfetchr
//
//  Created by Jaewon Lee on 7/25/18.
//  Copyright © 2018 SJJ. All rights reserved.
//

import UIKit

class StarChartVC: UIViewController {

    @IBAction func starDownGest(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindSegueStarVCWithSegue", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
