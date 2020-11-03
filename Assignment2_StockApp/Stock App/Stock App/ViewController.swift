//
//  ViewController.swift
//  Stock App
//
//  Created by Valentina Song on 10/26/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import Alamofire
import SwiftSpinner
import SwiftyJSON

class ViewController: UIViewController
{
    @IBOutlet weak var txtStock: UITextField!
    @IBOutlet weak var lblGetCEO: UILabel!
    @IBOutlet weak var lblGetPrice: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func lblGetValue(_ sender: Any)
    {
        guard let stockName = txtStock.text else {return}
        //print(stockName)
        
        let url = "\(apiURL)\(stockName)?apikey=\(apiKey)"
        //print(url)
        getStockValue(url, stockName)
    }
    
    func getStockValue(_ stockURL : String!, _ stockName : String!)
    {
        SwiftSpinner.show("Getting Stock Value for \(String(describing: stockName))")
        AF.request(stockURL).responseJSON
            {(response) in
                SwiftSpinner.hide()
                
                if response.error == nil
                {
                    guard let jsonString = response.data else{return}
                    guard let stockJSON : [JSON] = JSON(jsonString).array else{return}

                    if stockJSON.count < 1
                    {
                        return
                    }
                    
                    guard let price = stockJSON[0]["price"].double else{return}
                    guard let ceo = stockJSON[0]["ceo"].rawString() else{return}

                    self.lblGetPrice.text = "\(price)"
                    self.lblGetCEO.text = "\(ceo)"
                }
        }
    }
}

