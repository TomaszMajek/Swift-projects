import Foundation
import FoundationNetworking

struct Initial: Decodable {
    let sys: Sys
    let name: String
    let main: Temps
    let wind: Wiatr
}

struct Sys: Decodable {
    let country: String
}

struct Temps: Decodable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
}

struct Wiatr: Decodable {
    let speed: Float
}

func weatherFunc() {
    let group = DispatchGroup.init()

    group.enter()

    let jsonUrlString = "http://api.openweathermap.org/data/2.5/weather?q=Warsaw&appid=776972ea779842e9f6a1fa26131923fe&units=metric"

    guard let url = URL(string: jsonUrlString) else {
        return
    }

    URLSession.shared.dataTask(with: url, completionHandler: { data, response, err -> Void in defer {
            group.leave()
        }
        guard let data = data else {return}
        do {
            let forecast = try JSONDecoder().decode(Initial.self, from: data)
            
            //dump(forecast)

            print("\n", forecast.sys.country)
            print(forecast.name, "\n")
            print("Temperatura: ", forecast.main.temp)
            print("\tOdczuwalna", forecast.main.feels_like)
            print("\tMaksymalna", forecast.main.temp_max)
            print("\tMinimalna", forecast.main.temp_min)
            print("\nPrędkość wiatru: ", forecast.wind.speed)

            print("\n")

        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
        
    }).resume()

    group.wait()
}

weatherFunc()