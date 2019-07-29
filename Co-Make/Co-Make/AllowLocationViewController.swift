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
    
    var locationManager: CLLocationManager!
    var latitude: Double = 0
    var longitude: Double = 0

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
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let mainView = sb.instantiateViewController(withIdentifier: "MainView")
        present(mainView, animated: true, completion: nil)
    
    }
    
    func getZip(latitude: Double, longitude: Double) {
        var zipCode: String = ""
        let address = CLGeocoder.init()
        address.reverseGeocodeLocation(CLLocation.init(latitude: latitude, longitude: longitude)) { (places, error) in
            if error == nil{
                if let place = places {
                    zipCode = place[0].postalCode!
//                    user.zipcode = zipCode
                    print(zipCode)
                    
                }
            }
        }
    }
    
    func determineMyCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
            //locationManager.startUpdatingHeading()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        manager.stopUpdatingLocation()
        
        latitude = userLocation.coordinate.latitude
        longitude = userLocation.coordinate.longitude
        
        getZip(latitude: latitude, longitude: longitude)
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
