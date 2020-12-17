//
//  InfectionData.swift
//  Covid19Tracker
//
//  Created by Valentina Song on 12/16/20.
//  Copyright © 2020 Simeng Song. All rights reserved.
//

import Foundation

class InfectionData
{
    var country : String
    var confirmed : Int64
    var deaths : Int64
    var recovered : Int64
    
    init(country : String, confirmed : Int64, deaths : Int64, recovered : Int64){
        self.country = country;
        self.confirmed = confirmed;
        self.deaths = deaths;
        self.recovered = recovered;
    }
}
