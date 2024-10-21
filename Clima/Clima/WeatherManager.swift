import Foundation

protocol WeatherManagerDelegate{
    func WeatherUpdate(weather: WeatherModel)
}

class WeatherManager{
    let weatherURL="https://api.openweathermap.org/data/2.5/weather?appid=8e5b4f38ec9ad19682397f7eddeee555&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func findWeatherByCoordinate(latitude: Double, longitude: Double){
        let url=weatherURL+"&lat=\(latitude)&lon=\(longitude)"
        print(url)
        performRequest(url: url)
    }
    
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
//            let dataString = String(data:safeData, encoding: .utf8)
            
            if let weatherObject = self.parseJSON(data: safeData){
                delegate?.WeatherUpdate(weather: weatherObject)
            }
            
        }
        
    }
    
    func parseJSON(data: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
    
            do{
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                let weather = WeatherModel(temperature: weatherData.main.temp, id: weatherData.weather[0].id, city: weatherData.name)
                
                return weather
            }
            catch{
                print(error)
                return nil
            }
        }
    }

