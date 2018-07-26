//
//  ChangeCityNameViewController.swift
//  GetWeather
//
//  Created by kiran on 4/9/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
//Write the protocol declaration here:
protocol ChangeCityDeligete {
    func userEnteredCityName(city: String)
}

class ChangeCityNameViewController: UIViewController {
    
    var deligete:  ChangeCityDeligete?
    
    @IBOutlet weak var inputCity: UITextField!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getWeatherBtnPressed(_ sender: Any) {
        
        //1 Get the city name the user entered in the text field
        let cityName = inputCity.text!
        
        
        //2 If we have a delegate set, call the method userEnteredANewCityName
        
        deligete?.userEnteredCityName(city: cityName)

        //3 dismiss the Change City View Controller to go back to the WeatherViewController
        self.dismiss(animated: true, completion: nil)

    }
    
    
     //This is the IBAction that gets called when the user taps the back button. It dismisses the ChangeCityViewController.
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
