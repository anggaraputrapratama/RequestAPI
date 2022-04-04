//
//  ViewController.swift
//  RequestAPI
//
//  Created by Anggara Putra Pratama on 04/04/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.\
        let url = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&formatted=0"
        getData(from: url)
    }
    
    private func getData(from url: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: {data, response, error in
            
            guard let data = data, error == nil else{
                print("Something went wrong")
                return
            }
           
            // have data
            
            var result: Response?
            do{
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch{
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let json = result else{
                return
            }
            
            //print(json.message)
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
            print(json.results.solar_noon)
        })
        
        task.resume()
    }


}



struct Response: Codable{
    let results: MyResult
    let status: String
}

struct MyResult: Codable{
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}
