//
//  BitCoinPriceViewController.swift
//  GetWeather
//
//  Created by kiran on 5/15/18.
//  Copyright © 2018 kiran. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BitCoinPriceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let mainUrl = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["NPR","AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var  finalUrl = ""
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var uiPickerView: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        finalUrl = mainUrl + currencyArray[row]
        getBitcoinData(url: finalUrl)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiPickerView.dataSource = self
        uiPickerView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getBitcoinData(url: String) {
        Alamofire.request(url, method: .get).responseJSON {
            response in
            if response.result.isSuccess{
                print("got the bitcoin data ")
                
                let bitcoinJSON: JSON = JSON(response.result.value!)
                self.updateBitcoinData(json: bitcoinJSON)
            }
            else{
                print("error \(String(describing: response.result.error))")
                self.priceLabel.text = "cant connect"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
    //Write the update bitcoinData method here:
    func updateBitcoinData(json: JSON) {
         let bitcoinResult = json["ask"].double
        let bid = json["bid"].double
        let last = json["last"].double
        let high = json["high"].double
        let low = json["low"].double
        priceLabel.text = ("todays, high:\(high ?? 100), average:\(bitcoinResult ?? 100), bid:\(bid ?? 100), last:\(last ?? 100), low: \(low ?? 100)")

    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

