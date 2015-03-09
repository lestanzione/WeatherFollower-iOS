//
//  WeatherViewController.swift
//  Weather Follower
//
//  Created by Leandro on 3/3/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var citiesTable: UITableView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    //var cities: [String] = ["Sao Paulo", "Rio de Janeiro"]
    var citiesToSearch: [String] = []
    
    var citiesResult: [CityResult] = []
    
    var executedCities: Int = 0
    var runningThread: Bool = false
    
    @IBAction func startRequestPressed(sender: UIButton) {
        
        startOperation()
        
    }
    
    func startOperation() -> Void {
        
        if self.runningThread {
            println("Operation already running..")
            return
        }
        
        self.loadingIndicator.startAnimating()
        
        self.executedCities = 0
        self.citiesResult.removeAll(keepCapacity: false)
        self.citiesToSearch.removeAll(keepCapacity: false)
        
        let qualityOfServiceClass = QOS_CLASS_BACKGROUND
        let backgroundQueue = dispatch_get_global_queue(qualityOfServiceClass, 0)
        dispatch_async(backgroundQueue, {
            
            println("Running in background queue..")
            
            self.runningThread = true;
            
            self.getActivatedCities()
            
            for city in self.citiesToSearch {
                
                self.getCityResultHTML(city)
                
                //sleep(3)
                
            }
            
        })
        
    }
    
    func getCityResultHTML(city: String) -> Void {
        
        println("Starting search for city: " + city)
        
        var currentCity: String = ""
        
        if city == "Sao Paulo" {
            currentCity = "558/saopaulo-sp"
        }
        else if city == "Rio de Janeiro" {
            currentCity = "321/riodejaneiro-rj"
        }
        else if city == "Curitiba" {
            currentCity = "271/curitiba-pr"
        }
        else if city == "Florianopolis" {
            currentCity = "377/florianopolis-sc"
        }
        else if city == "Salvador" {
            currentCity = "56/salvador-ba"
        }
        
        var cityHtml: String = ""
        
        var url = NSURL(string: "http://www.climatempo.com.br/previsao-do-tempo/cidade/" + currentCity)
        var task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
            
            //println(response)
            
            if error == nil {
                
                //println(data)
                
                cityHtml = NSString(data: data, encoding: UInt())!
                
                //println(cityHtml)
                
                var currentTemperature: String = self.getCurrentTemperature(cityHtml)
                
                println(currentTemperature)
                
                self.executedCities++
                
                var cityResult: CityResult = CityResult(cityName: city, currentTemperature: currentTemperature)
                self.citiesResult.append(cityResult)
                
                if self.executedCities == self.citiesToSearch.count {
                    println("Searched for all cities!")
                    self.populateTable()
                }
                
            }
            else {
                
                println(error)
                
            }
            
            
        })
        
        task.resume()
        
    }
    
    func getCurrentTemperature(html: String) -> String {
        
        var temperature: String = ""
        
        var arr = html.componentsSeparatedByString("temp-momento\">")
        if arr.count > 1 {
            var temperatureArr = arr[1].componentsSeparatedByString("</span>")
            if temperatureArr.count > 1 {
                temperature = temperatureArr[0]
            }
        }
        
        return temperature
        
    }
    
    func getActivatedCities() -> Void {
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        if defaults.boolForKey(Configs.CITY_ACTIVATED_1) {
            citiesToSearch.append("Sao Paulo")
        }
        
        if defaults.boolForKey(Configs.CITY_ACTIVATED_2) {
            citiesToSearch.append("Rio de Janeiro")
        }
        
        if defaults.boolForKey(Configs.CITY_ACTIVATED_3) {
            citiesToSearch.append("Curitiba")
        }
        
        if defaults.boolForKey(Configs.CITY_ACTIVATED_4) {
            citiesToSearch.append("Florianopolis")
        }
        
        if defaults.boolForKey(Configs.CITY_ACTIVATED_5) {
            citiesToSearch.append("Salvador")
        }
        
    }
    
    func populateTable() -> Void {
        
        dispatch_async(dispatch_get_main_queue(), {
            
            for currentCity in self.citiesResult {
                
                println(currentCity.cityName + " - " + currentCity.currentTemperature)
                
            }
            
            self.citiesTable.reloadData()
            
            self.runningThread = false
            
            self.loadingIndicator.stopAnimating()
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        println("Test")
        
        self.citiesTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        println(animated)
        
        startOperation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.citiesResult.count
      
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell = self.citiesTable.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.citiesResult[indexPath.row].cityName + " - " + self.citiesResult[indexPath.row].currentTemperature
        
        return cell;
        
    }
    
}
