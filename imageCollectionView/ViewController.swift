//
//  ViewController.swift
//  imageCollectionView
//
//  Created by 503-03 on 22/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //이미지 파일의 이름을 저장할 배열
    var imageNames = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...7{
            imageNames.append("\(i).jpg")
        }
        
        //컬랙션 뷰의 출력과 이벤트 핸들링을 담당할 인스턴스
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    //섹션별 item의 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return imageNames.count
    }
    //셀을 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionViewCell
        //이미지 출력 설정
        cell.imageView.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
}
