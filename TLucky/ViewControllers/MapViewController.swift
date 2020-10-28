//
//  ViewController.swift
//  TLucky
//
//  Created by ggyool on 2020/10/28.
//

import UIKit
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        mapView.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        mapView.showsUserLocation = true
        

    }
    
    func setMapView(_ coordinate: CLLocationCoordinate2D) {
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01) // 0.01 - 100배 확대
        let region: MKCoordinateRegion = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func setMapViewCurrentLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        setMapView(coordinate)
    }
    
    @IBAction func touchUpCurrentLocationButton(_ sender: UIButton) {
        setMapViewCurrentLocation()
    }
    
}



// delegate
extension MapViewController {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("승인")
            setMapViewCurrentLocation()
//            locationManager.startUpdatingLocation()
        case .denied:
            print("거부")
        case .notDetermined:
            print("결정x")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("제한")
        default:
            print("ios 업데이트로 새로 생긴 값")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        print(location.coordinate)
        
    }
}


// event
extension MapViewController {
    
}
