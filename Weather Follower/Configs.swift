//
//  Configs.swift
//  Weather Follower
//
//  Created by Leandro on 3/4/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

import Foundation

class Configs {
    
    struct Static {
        
        static var CITY_ACTIVATED_1: String = "ActivatedCity1"
        static var CITY_ACTIVATED_2: String = "ActivatedCity2"
        static var CITY_ACTIVATED_3: String = "ActivatedCity3"
        static var CITY_ACTIVATED_4: String = "ActivatedCity4"
        static var CITY_ACTIVATED_5: String = "ActivatedCity5"
        
    }
    
    class var CITY_ACTIVATED_1: String {
        get {
            return Static.CITY_ACTIVATED_1
        }
    }
    
    class var CITY_ACTIVATED_2: String {
        get {
            return Static.CITY_ACTIVATED_2
        }
    }
    
    class var CITY_ACTIVATED_3: String {
        get {
            return Static.CITY_ACTIVATED_3
        }
    }
    
    class var CITY_ACTIVATED_4: String {
        get {
            return Static.CITY_ACTIVATED_4
        }
    }
    
    class var CITY_ACTIVATED_5: String {
        get {
            return Static.CITY_ACTIVATED_5
        }
    }
    
}
