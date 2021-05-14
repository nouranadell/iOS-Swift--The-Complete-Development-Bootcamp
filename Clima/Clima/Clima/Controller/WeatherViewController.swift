//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation   //for location

class WeatherViewController: UIViewController  {
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()            //location
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        searchField.delegate = self
        weatherManager.delegate = self
    }
    
    @IBAction func searchPressed(_ sender: UIButton) {   
        searchField.endEditing(true)
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()                       //to request location again
    }
    
}

//MARK: - Weather Manager Delegate Section.
extension WeatherViewController: WeatherManagerDelegate {
    
    func didUpdateWeather (_ weatherManager: WeatherManager,weather : WeatherModel){
        DispatchQueue.main.async {                           //to avoid completion handler error and wait for network delay
            self.temperatureLabel.text = weather.tempString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.text=weather.cityName
            
        }
        
        
    }
    
    
    func didFailWithError(error: Error){
        print(error)
    }
    
}
//MARK: - Text Field Delegate Section.
extension WeatherViewController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {  //function of return key action
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        //notice that textfield is used and not the text field name so it could be applicable to all text fields
        if textField.text != "" {
            return true
        }
        else {
            textField.placeholder = "Type Something"
            return false
        }
    }
    
    //when user is done editing and there is data written
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchField.text{
            weatherManager.fetchWeather(cityName: city)
        }
        
        //clears the text in textfield
        searchField.text = ""
    }
}

//MARK: - Location
extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()  //to be able to refetch the location upon button pressed
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
            
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
