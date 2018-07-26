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
        session.isOpen() ? session.close() : ()
        
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
        // }, authTypes: [NSNumber(value: KOAuthType.account.rawValue)!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
