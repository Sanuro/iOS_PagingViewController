//
//  Info ChartVC.swift
//  dogfetchr
//
//  Created by Jaewon Lee on 7/25/18.
//  Copyright © 2018 SJJ. All rights reserved.
//

import UIKit
import Charts

class Info_ChartVC: UIViewController {

    @IBOutlet weak var lineChart: LineChartView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func infoChartUpSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindSegueInfoVCWithSegue", sender: self)
    }
    

}
