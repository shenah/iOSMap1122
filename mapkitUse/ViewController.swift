//
//  ViewController.swift
//  mapkitUse
//
//  Created by 503-03 on 22/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {

    var locationManager : CLLocationManager!
    
    @IBOutlet weak var mapView: MKMapView!
    //현재 위치로 zoom
    @IBAction func zoom(_ sender: Any) {
        //맵 부에서 현재 사용자의 위치 가져오기
        let userLocation = mapView.userLocation
        //출력 영영 만들기
        let region = MKCoordinateRegion(center: userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        //맵 뷰에 출력
        mapView.setRegion(region, animated: true)
    }
    //지도 타입(표준-위성) 변환
    @IBAction func type(_ sender: Any) {
        
        if mapView.mapType == .satellite{
            mapView.mapType = .standard
        }else{
            mapView.mapType = .satellite
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //위치정보 사용 객체 생성
        locationManager = CLLocationManager()
        //위치정보 사용 권한을 묻는 대화상자 출력
        locationManager.requestWhenInUseAuthorization()
        //맵 뷰에 현재 위치를 출력
        mapView.showsUserLocation = true
        
        //mapView의 delegate 설정
        mapView.delegate = self
    }
}

extension ViewController : MKMapViewDelegate{
    //사용자 위치가 변경된 경우 호출하는 메소드
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        mapView.centerCoordinate = userLocation.coordinate
    }
}

