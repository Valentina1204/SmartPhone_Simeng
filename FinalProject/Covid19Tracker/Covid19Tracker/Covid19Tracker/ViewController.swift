//
//  ViewController.swift
//  Covid19Tracker
//
//  Created by Valentina Song on 12/16/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SwiftSpinner
import Charts

class ViewController: UIViewController
{
    
    @IBOutlet weak var trackerTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var textField = UITextField()
    
    @IBAction func addNewCountry(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Add a new country's cases", message: "Type Country code", preferredStyle: .alert)
                           
        let OK = UIAlertAction(title: "OK", style: .default) { (action) in
            self.getLastestData()
        }
                   
        let Cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("Cancel Pressed")
        }
                   
        alert.addTextField { (addTextField) in
            addTextField.placeholder = "Country code"
            self.textField = addTextField
        }
        alert.addAction(Cancel)
        alert.addAction(OK)
               
                   
        self.present(alert, animated: true, completion: nil)
    }
    
    var data: [InfectionData] = [InfectionData]()
    var searchData: [InfectionData] = [InfectionData]()
    
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        trackerTable.delegate = self
        trackerTable.dataSource = self
        
        searchBar.delegate = self
        
        
        data.append(InfectionData(country: "CHN", confirmed: 94427, deaths: 4754, recovered: 88122))
        data.append(InfectionData(country: "USA", confirmed: 16518420, deaths: 300754, recovered: 7720793))
        data.append(InfectionData(country: "IND", confirmed: 9906165, deaths: 143709, recovered: 9422636))
        data.append(InfectionData(country: "GRC", confirmed: 125173, deaths: 3687, recovered: 230739))
        data.append(InfectionData(country: "JAC", confirmed: 9906165, deaths: 143709, recovered: 9422636))
        data.append(InfectionData(country: "KOR", confirmed: 44364, deaths: 600, recovered: 32559))
        
        searchData.append(InfectionData(country: "CHN", confirmed: 94427, deaths: 4754, recovered: 88122))
        searchData.append(InfectionData(country: "USA", confirmed: 16518420, deaths: 300754, recovered: 7720793))
        searchData.append(InfectionData(country: "IND", confirmed: 9906165, deaths: 143709, recovered: 9422636))
        searchData.append(InfectionData(country: "GRC", confirmed: 125173, deaths: 3687, recovered: 230739))
        searchData.append(InfectionData(country: "JAC", confirmed: 9906165, deaths: 143709, recovered: 9422636))
        searchData.append(InfectionData(country: "KOR", confirmed: 44364, deaths: 600, recovered: 32559))
    }
    
    
    func getLastestData()
    {
        var URL = url

        URL.append(self.textField.text!)
        URL.append("/latest")
        
        SwiftSpinner.show("Getting Lastest Worldwide Infection Data")
        AF.request(URL).responseJSON{(response) in
            SwiftSpinner.hide()
            
            if response.error == nil{
                guard let jsonString = response.data else { return }
                
                guard let lastestData: [JSON] = JSON(jsonString).array else { return }
                
                if lastestData.count < 1 { return }
            
                for infection in lastestData{
                    let cou = self.textField.text!
                    guard let con = infection["result"]["confirm"].int64 else {return}
                    guard let dea = infection["result"]["deaths"].int64 else {return}
                    guard let rec = infection["result"]["recovered"].int64 else {return}
                    
                    let infe = InfectionData(country: cou, confirmed: con, deaths: dea, recovered: rec)
                    self.data.append(infe)
                    self.searchData.append(infe)
                }
                
                self.trackerTable.reloadData()
            }
        }
    }
    
    

}

extension ViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCell", owner: self, options: nil)?.first as! TableViewCell
        cell.lblCountry.text = data[indexPath.row].country
        cell.lblConfirmed.text = String(data[indexPath.row].confirmed)
        cell.lblDeaths.text = String(data[indexPath.row].deaths)
        cell.lblRecovered.text = String(data[indexPath.row].recovered)
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let task = models[indexPath.row]
            DeleteTaskFromDB(task: task)
            models.remove(at: indexPath.row)
            searchModels.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }*/
}

extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        guard !searchBar.text!.isEmpty else{
            data = searchData
            self.trackerTable.reloadData()
            return
        }
        data = searchData.filter({(InfectionData) -> Bool in
            return InfectionData.country.uppercased().contains(searchText.uppercased())
        })
        
        self.trackerTable.reloadData()
    }
}

