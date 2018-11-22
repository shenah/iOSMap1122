//
//  ViewController.swift
//  location
//
//  Created by 503-03 on 22/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController, CLLocationManagerDelegate {
    //위치정보 사용을 위한 인스턴스를 생성
    var locationManager = CLLocationManager()
    //시작위치를 저장할 변수
    var startLocation : CLLocation!
    
    @IBOutlet weak var lblLatitude: UILabel!
    @IBOutlet weak var lblLongitude: UILabel!
    @IBOutlet weak var lblAltitude: UILabel!
    @IBOutlet weak var lblDistence: UILabel!
    
    
    var flag = true
    @IBAction func locationUpdate(_ sender: Any) {
    /*    if flag == true{
         
        }else{
            flag = true
        }*/
        let btn = sender as! UIButton
        if btn.title(for: .normal) == "위치정보수집시작"{
            locationManager.startUpdatingLocation()
            locationManager.pausesLocationUpdatesAutomatically = true
            btn.setTitle("위치정보수집중지", for: .normal)
        }else{
            //위치정보 수집중지
            locationManager.stopUpdatingLocation()
            btn.setTitle("위치정보수집시작", for: .normal)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //정밀도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //delegate 설정
        locationManager.delegate = self
        
        //위치정보 사용 동의 대화상자 출력 - 실행 중에만 사용
        locationManager.requestWhenInUseAuthorization()
    }

    //Mark: 위치정보 갱신과 관련된 메소드
    
    //위치정보를 가져오는데 성공했을 때 호출되는 메소드
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        //배열에서 마지막 위치정보 객체 1개 가져오기
        let lastLocation = locations[locations.count - 1]
        //위도 경도 고도 출력
        lblAltitude.text = "\(lastLocation.altitude)"
        lblLatitude.text = "\(lastLocation.coordinate.latitude)"
        lblLongitude.text = "\(lastLocation.coordinate.longitude)"
        
        if startLocation == nil{
            startLocation = lastLocation
        }
        //거리계산
        let distence = lastLocation.distance(from: startLocation)
        lblDistence.text = "\(distence)"
    }
}

