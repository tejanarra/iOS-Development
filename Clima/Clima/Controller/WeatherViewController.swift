//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController  {

    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    let weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self

        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
    }
}

//MARK: - LocationDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let long = location.coordinate.longitude
            
            weatherManager.findWeatherByCoordinate(latitude: lat, longitude: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
}


//MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func locationClicked(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    @IBAction func SearchClicked(_ sender: UIButton) {
        
        
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        searchField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        weatherManager.findWeatherByCity(city: searchField.text!)
        searchField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(searchField.text != ""){
            return true}
        else{
            return false}
    }
}

//MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate {
    func WeatherUpdate(weather: WeatherModel) {
        DispatchQueue.main.async {
            print(weather.icon)
            self.conditionImageView.image = UIImage(systemName: weather.icon)
            self.temperatureLabel.text = weather.temperatureString
            self.cityLabel.text = weather.city
        }
    }
}
