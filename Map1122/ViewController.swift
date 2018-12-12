//
//  ViewController.swift
//  Map1122
//
//  Created by 503-03 on 22/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit
//연락처
import Contacts
//지도
import MapKit
//위치정보
import CoreLocation
class ViewController: UIViewController {
    
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var zip: UITextField!
    //주소에 해당하는 위도와 경도 정보를 저장할 변수
    var coords : CLLocationCoordinate2D?
    
    func map(){
        //지도를 출력하는 사용자 정의 메소드
        //입력한 내용 가져오기
        if let stateString = state.text,
            let cityString = city.text,
            let addressString = address.text,
            let zipString = zip.text,
            let coordinates = coords{
            //주소 객체
            let addressDict = [CNPostalAddressStateKey:stateString, CNPostalAddressCityKey:cityString, CNPostalAddressStreetKey:addressString, CNPostalAddressPostalCodeKey:zipString]
            //지도를 출력할 장소 만들기
            let place = MKPlacemark(coordinate: coordinates, addressDictionary: addressDict)
            //지도에 출력할 장소를 포함할 객체 만들기
            let mapItem = MKMapItem(placemark: place)
            //지도 옵션 설정
            let options = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving]
            //지도 출력
            mapItem.openInMaps(launchOptions: options)
        }
        
    }
    
    @IBAction func showMap(_ sender: Any) {
        //역 지오코딩: 주소정보를 가지고 위치정보를 찾아오는 것
        //다음이나 네이버의 오픈 API를 이용해도 되고 애플의 경우는 MapKit에서이 기능을 제공합니다.
        //구글도 제공
        if let stateString = state.text,
            let cityString = city.text,
            let addressString = address.text,
            let zipString = zip.text{
            let address = "\(addressString) \(cityString) \(stateString) \(zipString)"
            //위도 경도 찾아오기
            CLGeocoder().geocodeAddressString(address, completionHandler: {(placemarks, error) in
                //에러가 발생한 경우 - 인터넷이 안되가나 주소 잘못된 경우
                if error != nil{
                    print("FAIL:\(error!.localizedDescription)")
                }else if let marks = placemarks, marks.count>0{
                    //첫번째 데이터 가져오기
                    //주소를 가지고 위도경도를 찾으면 여러개
                    let placemark = marks[0]
                    //주소를 저장하고 지도 출력하는 메소드 호출
                    if let location = placemark.location{
                        self.coords = location.coordinate
                        self.map()
                    }
                }
            })
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
}

