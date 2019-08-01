//
//  AllowLocationViewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/28/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit
import CoreLocation

class AllowLocationViewController: UIViewController, CLLocationManagerDelegate {
    
    var apiController = ApiController()
    var locationManager: CLLocationManager!
    var latitude: Double = 0
    var longitude: Double = 0
    var name: String?
    var email: String?
    var password: String?
    var zipCode: String? {
        didSet {
            setupModelAndSegue()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func allowLocationTapped(_ sender: UIButton) {
        self.determineMyCurrentLocation()
        
    }
    
    func setupModelAndSegue(){
        
        if let name = self.name,
            let email = self.email,
            let password = self.password,
            let zipCode = self.zipCode {
            
            guard let unwrappedZip = Int(zipCode) else { return }
            
            let userRep = UserRepresentation(id: nil, username: name, email: email, password: password, zipCode: unwrappedZip)
            print(userRep.email)
            
            self.apiController.signUp(with: userRep) { _,_ in
                DispatchQueue.main.async {
                    let sb = UIStoryboard(name: "Main", bundle: nil)
                    //call create user function from API controller
                    
                    let mainView = sb.instantiateViewController(withIdentifier: "MainView")
                    self.present(mainView, animated: true, completion: nil)
                }
                
            }
            
           
            
            
        }
        
    }
    
    func getZip(latitude: Double, longitude: Double) -> String? {
        let address = CLGeocoder.init()
        var zipCodePlaceHolder: String?
        address.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude: longitude)) { (places, error) in
            if error == nil{
                if let place = places {
                    zipCodePlaceHolder = place[0].postalCode!
                    
                    // Assign zipcode to user here.
                    // Convert to Int when assigning.
//                    user.zipcode = zipCode
                    print(zipCodePlaceHolder)
                    
                }
            }
        }
        return zipCodePlaceHolder
    }
    
    // Presents alert that will allow users to enable location services for app.
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            locationManager.startUpdatingHeading()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        // Gets zip code from coordinates.
        
        if let zipCode = getZip(latitude: latitude, longitude: longitude){
            if self.zipCode == nil {
                self.zipCode = zipCode
            }
            
        }
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
