//
//  countryApi.swift
//  API
//
//  Created by Doaa on 20/02/2024.
//

import Foundation

protocol CountryApiDelegate:AnyObject{
   func didRetrieveCountryInfo(country : Country)
   
}

class CountryApi{
    weak var delegate : CountryApiDelegate?
    
    
    let urlBaseString = "https://restcountries.com/v3.1/name/"
    
    
    func fetchData(countryName : String){
        let urlString = "\(urlBaseString)\(countryName)"
        print(urlString)
        if let url = URL(string: urlString) {
            
            let request = URLRequest(url: url)
            
            let session = URLSession(configuration: .default)
            
            
            let task = session.dataTask(with: request,completionHandler: { data, responce, error in
                if error == nil {
                    print(error?.localizedDescription , "no error ")
                }else {
                    print(error?.localizedDescription , " error ")
                }
                
                guard let data = data else {
                    print("there is no data")
                    return
                    
                }
                
                do {
                    let country: [Country] = try JSONDecoder().decode([Country].self, from: data)
                    // let country1: [Country] = try? JSONDecoder().decode([Country].self, from: data)
                    let firstCountry=country[0]
                    self.delegate?.didRetrieveCountryInfo(country:firstCountry)
                }catch{
                    print (error.localizedDescription)
                }
            })
            task.resume(
            )
        }
        
    }
}
