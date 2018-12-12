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
    //검색 결과를 저장할 아이템 배열
    var matchingItems : [MKMapItem] = [MKMapItem]()
    @IBOutlet weak var keyword: UITextField!
    
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
    
    func performSearch(){
        //기존 검색 내용 삭제
        matchingItems.removeAll()
        //검색 객체 만들기
        let request = MKLocalSearch.Request()
        //검색어과 검색영역 설정
        request.naturalLanguageQuery = keyword.text
        request.region = mapView.region
        //검색 요청 객체 생성
        let search = MKLocalSearch(request: request)
        //검색 요청과 핸들러
        search.start(completionHandler: {(response, error) in
            if error != nil{
                print("검색 중 에러")
            }else if response?.mapItems.count == 0{
                print("검색 결과 없음")
            }else{
                print("검색 성공")
                //전체 데이터 순회하면서
                for item in response!.mapItems{
                    // 데이터 한 개씩 저장
                    self.matchingItems.append(item)
                    //각각을 맵에 출력
                    let annotation = MKPointAnnotation()
                    //어노테이션 정보 생성
                    annotation.coordinate = item.placemark.coordinate
                    annotation.title = item.name
                    annotation.subtitle = item.phoneNumber
                    self.mapView.addAnnotation(annotation)
                }
            }
            
        })
    }
    @IBAction func search(_ sender: Any) {
        //키보드 제거
        let tf = sender as! UITextField
        tf.resignFirstResponder()
        //맵 뷰의 어노테이션 제거
        mapView.removeAnnotations(mapView.annotations)
        // 검색 메소드 호출
        performSearch()
        
    }
    
    @IBAction func moveDetail(_ sender: Any) {
        let detailTableViewCotroller = self.storyboard?.instantiateViewController(withIdentifier: "DetailTableViewController") as! DetailTableViewController
        detailTableViewCotroller.mapItems = matchingItems
        self.navigationController?.pushViewController(detailTableViewCotroller, animated: true)
    }
    
}

extension ViewController : MKMapViewDelegate{
    //사용자 위치가 변경된 경우 호출하는 메소드
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation){
        mapView.centerCoordinate = userLocation.coordinate
    }
}

