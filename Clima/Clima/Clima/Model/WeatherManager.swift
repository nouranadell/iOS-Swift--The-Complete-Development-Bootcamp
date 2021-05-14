//
//  WeatherManager.swift
//  Clima
//
//  Created by Nouran Adel on 7/4/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//
//-----------This file creates the URL and session and it's requirements and decodes the JSON file------
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=79c75c3f2d579a779e060ef556e2baa1&units=metric"
    
    var delegate : WeatherManagerDelegate?
    
    
    func fetchWeather (cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
        print(urlString)
    }
    
    func performRequest (urlString: String){
        //Create a URL
        
        if let url = URL(string: urlString){
            
            //Create a URLSession
            let session = URLSession(configuration: .default)
            
            //Give session a task
            //let task = session.dataTask(with: url, completionHandler: handle(data:  response:  error: ) )
            //----------------The previous functionality is switched with the use of closures-------------------
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(weatherData: safeData){   //calls the function parseJSON
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
                
            }
            
            //start task
            task.resume()
        }
        
    }
    //---------Inserted in code body of closure-------------------------
    //    func handle (data: Data? , response: URLResponse? , error: Error?){
    //        if error != nil {
    //            print(error!)
    //            return
    //        }
    //        if let safeData = data {
    //            let dataString = String(data: safeData, encoding: .utf8)
    //            print(dataString)
    //        }
    //
    //
    //    }
    func parseJSON (weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)    //returns an object
            let conditionID = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let city = decodedData.name
            let weather = WeatherModel(conditionId: conditionID, temperature: temp, cityName: city)
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
}
