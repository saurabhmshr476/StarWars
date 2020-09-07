//
//  Service.swift
//  StarWars
//
//  Created by SaurabhMishra on 06/09/20.
//  Copyright © 2020 SaurabhMishra. All rights reserved.
//

import Foundation

//MARK: - Netwrok Resource endPoint

enum Resource: String {
  case people, films, starships
  case vehicles, species, planets
}

//MARK: - Netwrok URL Builder

enum URLBuilder{
    static let baseUrl = "https://swapi.dev/api"
    static func buildUrl(for resource: Resource, withId id: Int? = nil) -> URL? {
      let urlString = baseUrl + "/\(resource.rawValue)"
      return URL(string: urlString)
    }
}

//MARK: - Netwrok  Service

class Service{
    
    static let shared = Service()
    private init(){
        
    }

    //MARK: - Person API Call
    func getPeople(completionHandler: @escaping (PersonData?,Error?)->()) {

        guard let url = URLBuilder.buildUrl(for: .people) else {return}
    
        let urlRequest:URLRequest = URLRequest(url: url)
    
        URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
            
            if let err = err{
                completionHandler(nil,err)
                return
            }
            
            guard let data = data else { return }

            do {
                let decoder = JSONDecoder()
                let personData = try decoder.decode(PersonData.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(personData,nil)
                }
            } catch _{
                print("Error in decoding")
            }
            
            
        }.resume()
        
        
    }
    
     //MARK: - Flim API Call
    func getFlim(urlStr:String,completionHandler: @escaping (Film?,Error?)->()) {

           guard let url = URL(string: urlStr) else {return}
       
           let urlRequest:URLRequest = URLRequest(url: url)
       
           URLSession.shared.dataTask(with: urlRequest) { (data, resp, err) in
               
               if let err = err{
                   completionHandler(nil,err)
                   return
               }
               
               guard let data = data else { return }

               do {
                   let decoder = JSONDecoder()
                   let flim = try decoder.decode(Film.self, from: data)
                   DispatchQueue.main.async {
                       completionHandler(flim,nil)
                   }
               } catch _{
                   print("Error in decoding")
               }
               
               
           }.resume()
           
           
       }
    
}
