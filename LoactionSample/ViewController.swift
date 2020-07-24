//
//  ViewController.swift
//  LoactionSample
//
//  Created by admin on 23/07/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureInitialLocaton()
    }

    override func viewDidAppear(_ animated: Bool) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func configureInitialLocaton() {
        let initialLocation = CLLocation(latitude: 12.9143, longitude: 77.6386)
        let coordinateRegion = MKCoordinateRegion(
            center: initialLocation.coordinate,
            latitudinalMeters: 1500,
            longitudinalMeters: 1500)
        mapView.setRegion(coordinateRegion, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = initialLocation.coordinate
        mapView.addAnnotation(pin)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            DispatchQueue.main.async {
                self.updateMapView(location:location)
            }
        }
    }
    
    func updateMapView(location:CLLocation) {
        mapView.removeAnnotations(mapView.annotations)
        let coordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude )
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        mapView.addAnnotation(pin)
    }
}
