import Foundation
class WeatherManager{
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=8e5b4f38ec9ad19682397f7eddeee555&units=metric"
    
    func findWeatherByCity(city: String){
        let url=weatherURL+"&q=\(city)"
        print(url)
        performRequest(url: url)
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
            let dataString = String(data:safeData, encoding: .utf8)
            print(dataString)
            
        }
        
    }
}
