//
//  ViewController.swift
//  API
//
//  Created by Doaa on 19/02/2024.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
   
    var locationManager = CLLocationManager()
    var geoCoder = CLGeocoder()
    
    var countryApi =  CountryApi()
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var regionLabel:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate=self
        countryApi.delegate=self
        locationManager.delegate=self
        
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {   
        updateUI()
    }
    
    @IBAction func locationButton(_ sender: UIButton) {
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.requestLocation()
        
        
    }
    
    func updateUI(){
        countryApi.fetchData(countryName: searchTextField.text!)
    }
}

extension ViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateUI()
        return true
    }
}
extension ViewController: CountryApiDelegate{
    func didRetrieveCountryInfo(country:Country) {
        print (country)
        
        DispatchQueue.main.async{
        self.nameLabel.text = country.name?.nativeName.eng.official
        self.capitalLabel.text = country.capital?.first
        self.regionLabel.text = country.region
        }
    }
}

extension ViewController : CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    //print (locations[0])
        let location=locations.last
        geoCoder.reverseGeocodeLocation(location!) { (places, error) in
//           print (places?.last?.isoCountryCode)
//            print (places?.last?.country)
            
            let cName=places?.last?.country!
            self.countryApi.fetchData(countryName: cName!)
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print (error)
    }
}

