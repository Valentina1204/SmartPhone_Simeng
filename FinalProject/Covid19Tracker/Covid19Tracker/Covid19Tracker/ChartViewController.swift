//
//  ChartViewController.swift
//  Covid19Tracker
//
//  Created by Valentina Song on 12/16/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {

    var country = [String]()
    var confirmed = [Int64]()
    var barChart = BarChartView()
    override func viewDidLoad() {
        super.viewDidLoad()

        barChart.delegate = self
        country.append("CHN")
        country.append("USA")
        country.append("IND")
        country.append("GRC")
        country.append("JAC")
        country.append("KOR")
        
        confirmed.append(94427)
        confirmed.append(16518420)
        confirmed.append(9906165)
        confirmed.append(125173)
        confirmed.append(9906165)
        confirmed.append(44364)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<country.count{
            let dataEntry = BarChartDataEntry(x: Double(i), y: Double(confirmed[i]))
            
            dataEntries.append(dataEntry)
        }
        
        barChart.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        barChart.center = view.center
        
        view.addSubview(barChart)
        
        let set = BarChartDataSet(dataEntries)
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
        set.colors = ChartColorTemplates.joyful()
    }
}
