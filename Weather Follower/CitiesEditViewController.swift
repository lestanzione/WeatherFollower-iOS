//
//  CitiesEditViewController.swift
//  Weather Follower
//
//  Created by Leandro on 3/4/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

import UIKit

class CitiesEditViewController: UIViewController {
    
    @IBOutlet var city1: UILabel!
    @IBOutlet var city2: UILabel!
    @IBOutlet var city3: UILabel!
    @IBOutlet var city4: UILabel!
    @IBOutlet var city5: UILabel!
    
    @IBOutlet var switch1: UISwitch!
    @IBOutlet var switch2: UISwitch!
    @IBOutlet var switch3: UISwitch!
    @IBOutlet var switch4: UISwitch!
    @IBOutlet var switch5: UISwitch!
    
    @IBAction func switchChanged(sender: UISwitch) {
        
        println(sender.tag)
        println(sender.on)
        
        switch sender.tag {
            case 1:
                changeCityTextStyle(city1, isSelected: sender.on)
                saveChange(Configs.CITY_ACTIVATED_1, configValue: sender.on)
            case 2:
                changeCityTextStyle(city2, isSelected: sender.on)
                saveChange(Configs.CITY_ACTIVATED_2, configValue: sender.on)
            case 3:
                changeCityTextStyle(city3, isSelected: sender.on)
                saveChange(Configs.CITY_ACTIVATED_3, configValue: sender.on)
            case 4:
                changeCityTextStyle(city4, isSelected: sender.on)
                saveChange(Configs.CITY_ACTIVATED_4, configValue: sender.on)
            case 5:
                changeCityTextStyle(city5, isSelected: sender.on)
                saveChange(Configs.CITY_ACTIVATED_5, configValue: sender.on)
            default:
                println("This message should not appear!")
        }
        
    }
    
    func changeCityTextStyle(changedCity: UILabel, isSelected: Bool) -> Void {
        
        if isSelected {
            changedCity.enabled = true
        }
        else{
            changedCity.enabled = false
        }
        
    }
    
    func saveChange(configId: String, configValue: Bool) -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(configValue, forKey: configId)
        
    }
    
    func getActivatedCities() -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        let isCity1Activated = defaults.boolForKey(Configs.CITY_ACTIVATED_1)
        changeCityTextStyle(city1, isSelected: isCity1Activated)
        switch1.on = isCity1Activated
        
        let isCity2Activated = defaults.boolForKey(Configs.CITY_ACTIVATED_2)
        changeCityTextStyle(city2, isSelected: isCity2Activated)
        switch2.on = isCity2Activated
        
        let isCity3Activated = defaults.boolForKey(Configs.CITY_ACTIVATED_3)
        changeCityTextStyle(city3, isSelected: isCity3Activated)
        switch3.on = isCity3Activated
        
        let isCity4Activated = defaults.boolForKey(Configs.CITY_ACTIVATED_4)
        changeCityTextStyle(city4, isSelected: isCity4Activated)
        switch4.on = isCity4Activated
        
        let isCity5Activated = defaults.boolForKey(Configs.CITY_ACTIVATED_5)
        changeCityTextStyle(city5, isSelected: isCity5Activated)
        switch5.on = isCity5Activated
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getActivatedCities()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
