//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate{
    func GotRate(rate:CurrencyModel)
}

class CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "Replace With Your Actual API KEY"
    
    var delegate:CoinManagerDelegate?
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String ){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        print(urlString)
                performRequest(url: urlString)
    }
    
    func performRequest(url:String){
            if let url = URL(string: url){
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
                task.resume()
            }
        }
        
        
        func handle(data: Data?, response: URLResponse?, error: Error?){
            if error != nil{
                print(error!)
                return
            }
            
            if let safeData = data{
                if let currencyObject = self.parseJSON(data: safeData){
                    print(currencyObject.getRate())
                    self.delegate?.GotRate(rate: currencyObject)
                }
                
            }
            
        }
        
    func parseJSON(data: Data) -> CurrencyModel?{
            let decoder = JSONDecoder()
        
                do{
                    let currenctData = try decoder.decode(CurrencyData.self, from: data)
                    let rate = CurrencyModel(from: currenctData.asset_id_base, to: currenctData.asset_id_quote, rate: currenctData.rate)
                    
                    return rate
                }
                catch{
                    print(error)
                    return nil
                }
            }
    
}
