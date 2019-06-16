//
//  ViewController.swift
//  CityWeatherApp
//
//  Created by Hari on 16/06/19.
//  Copyright © 2019 Hari. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController , CLLocationManagerDelegate , ChangedCityDelegate {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    let locationManager = CLLocationManager()
    var weatherDataModel = WeatherDataModel()
    let WEATHER_API = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "YOUR_WEATHER_API"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.changedCityDelegate = self
        }
    }
    
    func userChangedCity(name: String) {
        
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            let params : [String : String] = ["q" : name , "appid" : APP_ID]
            makeNetworkCall(parameter : params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count-1]
        if location.horizontalAccuracy >  0 {
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            let params : [String : String] = ["lat" : lat , "lon" : lon , "appid" : APP_ID]
            makeNetworkCall(parameter : params)
        }
        else{
            cityLabel.text = "Could not get accurate location !"
        }
    }
    
    
    func makeNetworkCall(parameter: [String : String]) {
        
        let urlComp = NSURLComponents(string: WEATHER_API)!
        var items = [URLQueryItem]()
        for (key,value) in parameter {
            items.append(URLQueryItem(name: key, value: value))
        }
        items = items.filter{!$0.name.isEmpty}
        if !items.isEmpty {
            urlComp.queryItems = items
        }
        var urlRequest = URLRequest(url: urlComp.url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
            
            if error == nil && data != nil {
                do {
                    let responseModel =  try JSONDecoder().decode(WeatherJSONData.self, from: data!)
                    DispatchQueue.main.async {
                        self.updateWeatherData (weatherData: responseModel)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        self.showError()
                    }
                }
            }
            else if error != nil
            {
                DispatchQueue.main.async {
                    self.showError()
                }
            }
        })
        task.resume()
    }
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        cityLabel.text = "Could not get location"
    }
    
    func updateWeatherData(weatherData: WeatherJSONData){
        
        print("weatherData = \(weatherData)")
        weatherDataModel = WeatherDataModel()
        
        if let tempResult = weatherData.main?.temp {
            
            weatherDataModel.city = weatherData.name!
            weatherDataModel.temperature = Int(tempResult - 273)
            weatherDataModel.condition = Int(weatherData.weather![0].id!)
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            updateUIWithWeatherData()
            
        }
        else {
            self.cityLabel.text = "Weather unavailable"
        }
    }
    
    func updateUIWithWeatherData() {
        
        cityLabel.text = weatherDataModel.city
        let tempWithSign = "\((weatherDataModel.temperature)) ℃"
        temperatureLabel.text =  tempWithSign
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
    
    func showError() {
        
        weatherDataModel = WeatherDataModel()
        cityLabel.text = "Error in getting weather"
        weatherIcon.image = UIImage(named: "dunno")
        temperatureLabel.text = ""
    }
    
}

