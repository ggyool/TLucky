//
//  ViewController.swift
//  TLucky
//
//  Created by ggyool on 2020/10/28.
//

import UIKit
import MapKit

//[]TODO: Transition관련 폴더정리
//[]TODO: TapGesture 추가하기 dimming area 눌렀을때, 메뉴 사라지게

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    let locationManager = CLLocationManager()
    let transition = SlideInTransition()
  
    
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
    
    //MenuAction
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenunViewController") as? MenuViewController else { return } //cast to MenuViewController to get MenuType which is returning the type
        menuViewController.didTapMenuType = { menuType in
            print(menuType) //get the menu Type from the MenuViewController
            self.transitionToNew(menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
    
    func transitionToNew(_ menuType: MenuType){
        //let title = String(describing: menuType).capitalized
        //switch로 view () 추가해서 바꿈 메뉴를 사용할 경우 
    }
}

// MARK: delegate sources
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

// Menu transition delegate
extension MapViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

