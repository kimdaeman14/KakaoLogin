//
//  LoginViewController.swift
//  KaKaoLoginExample
//
//  Created by Jo JANGHUI on 2018. 7. 26..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBAction private func loginButtonDidTap(_ sender: Any) {
        guard let session = KOSession.shared() else { return }
        // Close lod session
        // 기존꺼가 열려있으면 닫아라?
        session.isOpen() ? session.close() : ()
        
        //열어라 세션
        session.open(completionHandler: { (error) in
            if !session.isOpen() {
                // 에러코드는 KOErrorCode 참고
                if let error = error as NSError? {
                    switch error.code {
                    case Int(KOErrorCancelled.rawValue):    //에러코드가 열거형으로 들어 있습니다.
                        print("취소")
                    default:
                        print(error.localizedDescription)
                    }
                } else {
                    // Session Login 후처리는 KOSessionDidChange Notification을 통해 처리
                    print("성공")
                }
            }
        })
        // }, authTypes: [NSNumber(value: KOAuthType.account.rawValue)!) //예전에느 ㄴ이렇게썼대.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    

    
}
