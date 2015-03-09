//
//  CityResult.swift
//  Weather Follower
//
//  Created by Leandro on 3/3/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

import Foundation

class CityResult {
    
    var cityName: String = ""
    var currentTemperature: String = ""
    
    init(){
        
    }
    
    init(cityName: String, currentTemperature: String){
        self.cityName = cityName
        self.currentTemperature = currentTemperature
    }
    
}
