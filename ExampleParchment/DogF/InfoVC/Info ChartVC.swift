//
//  Info ChartVC.swift
//  dogfetchr
//
//  Created by Jaewon Lee on 7/25/18.
//  Copyright © 2018 SJJ. All rights reserved.
//

import UIKit
import Charts

var properties = ["f height", "m height", "f weight", "m weight", "life span"]

class Info_ChartVC: UIViewController {

    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var lineChart: LineChartView!
    
    @IBOutlet weak var radarChart: RadarChartView!
    
    let dataSetSize: CGFloat = 14
    var avg_prop:[Double] = []
    
    var dogsearched = "rottweiler"
    var dog_info: [Double] = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segment.isMomentary = false
        lineChart.isHidden = true
        
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.labelPosition = .bottom
        lineChart.leftAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.animate(xAxisDuration: 2)
        //        refresh()
        read_json()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func segmentTapped(_ sender: UISegmentedControl) {
        let getIndex = segment.selectedSegmentIndex
        print(getIndex)
        switch (getIndex) {
        case 0:
            lineChart.isHidden = true
            radarChart.isHidden = false
            radarChart.animate(xAxisDuration: 3)
        case 1:
            lineChart.isHidden = false
            radarChart.isHidden = true
            lineChart.animate(xAxisDuration: 2)
            
        default:
            break;
        } 
    }
    
    
    
    
    @IBAction func infoChartUpSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "unwindSegueInfoVCWithSegue", sender: self)
    }
    
    
    func read_json() {
        do {
            if let file = Bundle.main.url(forResource: "data", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? NSDictionary {
                    //                    if let specific_breed =
                    var count = 0.0
                    var fem_height = 0.0
                    var male_height = 0.0
                    var fem_weight = 0.0
                    var male_weight = 0.0
                    var life_span = 0.0
                    for (key,val) in object {
                        if let keyofbreeding = key as? String {
                            if keyofbreeding == dogsearched {
                                dog_info.append(getsum(breed_info_before: val, keydetail: "female height"))
                                dog_info.append(getsum(breed_info_before: val, keydetail: "male height"))
                                dog_info.append(getsum(breed_info_before: val, keydetail: "female weight"))
                                dog_info.append(getsum(breed_info_before: val, keydetail: "male weight"))
                                dog_info.append(getsum(breed_info_before: val, keydetail: "life span"))
                            }
                        }
                        
                        count  = count + 1
                        fem_height = fem_height + getsum(breed_info_before: val, keydetail: "female height")
                        male_height = male_height + getsum(breed_info_before: val, keydetail: "male height")
                        fem_weight = fem_weight + getsum(breed_info_before: val, keydetail: "female weight")
                        male_weight = male_weight + getsum(breed_info_before: val, keydetail: "male weight")
                        life_span = life_span + getsum(breed_info_before: val, keydetail: "life span")
                        
                    }
                    avg_prop.append(round(100 * (fem_height / count)) / 100)
                    avg_prop.append(round(100 * (male_height / count)) / 100)
                    avg_prop.append(round(100 * (fem_weight / count)) / 100)
                    avg_prop.append(round(100 * (male_weight / count)) / 100)
                    avg_prop.append(round(100 * (life_span / count)) / 100)
                    //                    print("fem height average is", (round(100 * (fem_height / count)) / 100))
                    //                    print("male height average is", (round(100 * (male_height / count)) / 100))
                    //                    print("fem weight average is", (round(100 * (fem_weight / count)) / 100))
                    //                    print("male weight average is", (round(100 * (male_weight / count)) / 100))
                    //                    print("life span average is", (round(100 * (life_span / count)) / 100))
                    setLineChartValues(specific_dog_info: dog_info, avg_info: avg_prop)
                    setRadarChartValues(specific_dog_info: dog_info, avg_info: avg_prop)
                    
                } else if let object = json as? [Any] {
                    // json is an array
                    print("array", object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    func getsum(breed_info_before: Any, keydetail: String)-> Double {
        var sum = 0.0
        if let breed_info = breed_info_before as? NSDictionary {
            if let key = breed_info[keydetail] as? NSArray {
                if let valuedetail = key[0] as? Double {
                    sum = sum + valuedetail
                }
            }
        }
        return sum
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    final class DateValueFormatter: IAxisValueFormatter {
        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            //            let return_this = properties
            //            return "Hello"
            return properties[Int(value)]
            //            return formatter.string(from: Date(timeIntervalSinceReferenceDate: value))
        }
        
        //        let formatter: DateFormatter
        //
        //        init(formatter: DateFormatter) {
        //            self.formatter = formatter
        //        }
    }
    
    
    func setLineChartValues(specific_dog_info: [Double], avg_info: [Double]) {
        let values = (0...4).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: avg_info[i])
        }
        
        let values2 = (0...4).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: specific_dog_info[i])
        }
        let set1 = LineChartDataSet(values: values, label: "Average")
        set1.setCircleColor(NSUIColor.red)
        //        set1.drawCirclesEnabled = false
        set1.setColor(NSUIColor.red)
        let set2 = LineChartDataSet(values: values2, label: dogsearched.capitalized)
        //        set2.drawCirclesEnabled = false
        //        set2.setCircleColor(NSUIColor.cyan)
        set2.lineDashPhase = CGFloat(0.5)
        let data = LineChartData(dataSets: [set1, set2])
        data.setDrawValues(false)
        
        lineChart.xAxis.valueFormatter = DateValueFormatter()
        lineChart.xAxis.labelCount = properties.count - 1
        lineChart.data = data
        self.lineChart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
        self.lineChart.leftAxis.labelFont = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
        self.lineChart.rightAxis.labelFont = UIFont(name: "HelveticaNeue-Bold", size: 12.0)!
        self.lineChart.legend.form = .circle
        self.lineChart.legend.font = UIFont(name: "HelveticaNeue-Bold", size: 15)!
        lineChart.gridBackgroundColor = .lightGray
        lineChart.legend.horizontalAlignment = .center
        
        let marker: BalloonMarker =  BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 16.0, right: 7.0))
        lineChart.marker = marker
        
        
        lineChart.chartDescription?.text = ""
        self.lineChart.data = data
        lineChart.animate(xAxisDuration: 3)
    }
    
    func setRadarChartValues(specific_dog_info: [Double], avg_info: [Double]) {
        let values = (0...4).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: avg_info[i])
        }
        
        let values2 = (0...4).map { (i) -> ChartDataEntry in
            return ChartDataEntry(x: Double(i), y: specific_dog_info[i])
        }
        let set1 = RadarChartDataSet(values: values, label: "Average")
        //        set1.fillColor = NSUIColor.red
        set1.setColor(NSUIColor.red)
        set1.fillColor = NSUIColor.red
        set1.lineWidth = 2.0
        set1.drawHighlightCircleEnabled = false
        set1.drawFilledEnabled = true
        set1.drawValuesEnabled = false
        let set2 = RadarChartDataSet(values: values2, label: dogsearched.capitalized)
        set2.setColor(NSUIColor.green)
        set2.lineWidth = 2.0
        set2.drawHighlightCircleEnabled = false
        set2.drawFilledEnabled = true
        set2.fillColor = NSUIColor.green
        set2.drawValuesEnabled = false
        radarChart.xAxis.valueFormatter = DateValueFormatter()
        let data = RadarChartData(dataSets: [set1, set2])
        
        radarChart.legend.horizontalAlignment = .center
        radarChart.chartDescription?.text = ""
        radarChart.data?.highlightEnabled = true
        self.radarChart.data = data
        radarChart.animate(xAxisDuration: 3)
        let marker: BalloonMarker =  BalloonMarker(color: UIColor.black, font: UIFont(name: "Helvetica", size: 12)!, textColor: UIColor.white, insets: UIEdgeInsets(top: 7.0, left: 7.0, bottom: 16.0, right: 7.0))
        radarChart.marker = marker
        
        
        
        
        
    }
    
    
    
}


open class BalloonMarker: MarkerImage
{
    open var color: UIColor
    open var arrowSize = CGSize(width: 15, height: 11)
    open var font: UIFont
    open var textColor: UIColor
    open var insets: UIEdgeInsets
    open var minimumSize = CGSize()
    
    fileprivate var label: String?
    fileprivate var _labelSize: CGSize = CGSize()
    fileprivate var _paragraphStyle: NSMutableParagraphStyle?
    fileprivate var _drawAttributes = [NSAttributedStringKey : AnyObject]()
    
    public init(color: UIColor, font: UIFont, textColor: UIColor, insets: UIEdgeInsets)
    {
        self.color = color
        self.font = font
        self.textColor = textColor
        self.insets = insets
        
        _paragraphStyle = NSParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        _paragraphStyle?.alignment = .center
        super.init()
    }
    
    open override func offsetForDrawing(atPoint point: CGPoint) -> CGPoint
    {
        var offset = self.offset
        var size = self.size
        
        if size.width == 0.0 && image != nil
        {
            size.width = image!.size.width
        }
        if size.height == 0.0 && image != nil
        {
            size.height = image!.size.height
        }
        
        let width = size.width
        let height = size.height
        let padding: CGFloat = 8.0
        
        var origin = point
        origin.x -= width / 2
        origin.y -= height
        
        if origin.x + offset.x < 0.0
        {
            offset.x = -origin.x + padding
        }
        else if let chart = chartView,
            origin.x + width + offset.x > chart.bounds.size.width
        {
            offset.x = chart.bounds.size.width - origin.x - width - padding
        }
        
        if origin.y + offset.y < 0
        {
            offset.y = height + padding;
        }
        else if let chart = chartView,
            origin.y + height + offset.y > chart.bounds.size.height
        {
            offset.y = chart.bounds.size.height - origin.y - height - padding
        }
        
        return offset
    }
    
    open override func draw(context: CGContext, point: CGPoint)
    {
        guard let label = label else { return }
        
        let offset = self.offsetForDrawing(atPoint: point)
        let size = self.size
        
        var rect = CGRect(
            origin: CGPoint(
                x: point.x + offset.x,
                y: point.y + offset.y),
            size: size)
        rect.origin.x -= size.width / 2.0
        rect.origin.y -= size.height
        
        context.saveGState()
        
        context.setFillColor(color.cgColor)
        
        if offset.y > 0
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + arrowSize.height))
            context.fillPath()
        }
        else
        {
            context.beginPath()
            context.move(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + rect.size.width,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width + arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            //arrow vertex
            context.addLine(to: CGPoint(
                x: point.x,
                y: point.y))
            context.addLine(to: CGPoint(
                x: rect.origin.x + (rect.size.width - arrowSize.width) / 2.0,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y + rect.size.height - arrowSize.height))
            context.addLine(to: CGPoint(
                x: rect.origin.x,
                y: rect.origin.y))
            context.fillPath()
        }
        
        if offset.y > 0 {
            rect.origin.y += self.insets.top + arrowSize.height
        } else {
            rect.origin.y += self.insets.top
        }
        
        rect.size.height -= self.insets.top + self.insets.bottom
        
        UIGraphicsPushContext(context)
        
        label.draw(in: rect, withAttributes: _drawAttributes)
        
        UIGraphicsPopContext()
        
        context.restoreGState()
    }
    
    open override func refreshContent(entry: ChartDataEntry, highlight: Highlight)
    {
        setLabel(String(entry.y))
    }
    
    open func setLabel(_ newLabel: String)
    {
        label = newLabel
        
        _drawAttributes.removeAll()
        _drawAttributes[.font] = self.font
        _drawAttributes[.paragraphStyle] = _paragraphStyle
        _drawAttributes[.foregroundColor] = self.textColor
        
        _labelSize = label?.size(withAttributes: _drawAttributes) ?? CGSize.zero
        
        var size = CGSize()
        size.width = _labelSize.width + self.insets.left + self.insets.right
        size.height = _labelSize.height + self.insets.top + self.insets.bottom
        size.width = max(minimumSize.width, size.width)
        size.height = max(minimumSize.height, size.height)
        self.size = size
    }
}
