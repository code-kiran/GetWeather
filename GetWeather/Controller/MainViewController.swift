//
//  MainViewController.swift
//  GetWeather
//
//  Created by kiran on 4/9/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class MainViewController: UIViewController, CLLocationManagerDelegate , ChangeCityDeligete{
    
    //Decleare Constant
    let WEATHER_URL = ""
    let APP_ID = ""
    
    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    
    @IBOutlet weak var labelTemperature: UILabel!
    
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var labelCity: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO:Set up the location manager here.
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        
    }
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(url: String, paramters: [String : String]) {
        
        Alamofire.request(url, method: .get, parameters: paramters).responseJSON {
            response in
            if response.result.isSuccess{
                print("got the weather data ")
                self.labelCity.text = "yay got the data"
                let weatherJSON: JSON = JSON(response.result.value!)
                print(weatherJSON)
                self.updateWeatherData(json: weatherJSON)
                
            }
            else{
                print("error \(String(describing: response.result.error))")
                self.labelCity.text = "cant connect wetherurl"
            }
        }
        
    }
    

    //MARK: - JSON Parsing
    /***************************************************************/
    
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json: JSON) {
        if  let tempResult = json["list"][0]["main"]["temp"].double {
            weatherDataModel.temperature = Int (tempResult - 273.4)
            weatherDataModel.city = json["city"]["name"] .stringValue
            weatherDataModel.condition = json["list"][0]["weather"][0]["id"].intValue
            weatherDataModel.weatherDescription = json["list"][0]["weather"][0]["description"].stringValue
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
            print(weatherDataModel.condition)
            updateUIWithWeatherData()
        }
        else{
            print("cant phrase data, weather unvaailable ")
        }
        
    }
    
    
    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    func updateUIWithWeatherData(){
        labelTemperature.text = String("\(weatherDataModel.temperature) ℃" )
        labelCity.text = ("\(weatherDataModel.weatherDescription) in \(weatherDataModel.city)")
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        
    }
//MARK: - Location Manager Delegate Methods
    /***************************************************************/
//Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        print(location)
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation() //it will lstop updating location once getting the value from array
            locationManager.delegate = nil
            print("latitude = \(location.coordinate.latitude), longitude = \(location.coordinate.longitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            let param: [String : String] = ["lat": latitude , "lon": longitude, "appId": APP_ID]
            getWeatherData(url: WEATHER_URL, paramters: param)
        }
    }
//Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        labelCity.text = "Cant get your location access"
    }
    
//MARK: - Change City Delegate methods
    /***************************************************************/
//Write the userEnteredANewCityName Delegate method here:
    func userEnteredCityName(city: String) {
        let params: [String: String] = ["q": city, "appId": APP_ID]
        getWeatherData(url: WEATHER_URL, paramters: params)
    }
    
    
    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeCityName"{
            let destinationVC = segue.destination as! ChangeCityNameViewController
            destinationVC.deligete = self
        }
    }
    
}



