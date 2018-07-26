//
//  MainViewController.swift
//  KakaoLoginTest
//
//  Created by kimdaeman14 on 2018. 7. 26..
//  Copyright © 2018년 GoldenShoe. All rights reserved.
//

import UIKit

//    [KOSessionTask talkProfileTaskWithCompletionHandler:^(KOTalkProfile* profile, NSError* error) {
//    if (profile) {
//    NSLog(@"%@",profile.nickName);
//    } else {
//    NSLog(@"failed to get talk profile.");
//    }
//    }];

class MainViewController: UIViewController {

    
    @IBOutlet weak var profileImageView:UIImageView!
    @IBOutlet weak var thumbnailImageView:UIImageView!
    @IBOutlet weak var nameLabel:UILabel!

    @IBAction private func logoutButton(_ sender: UIButton){
        KOSession.shared().close()
        KOSession.shared().logoutAndClose { (success, error) in
            switch success{
            case false :
                print(error)
            case true:
                self.dismiss(animated: true, completion: nil)
                
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        KOSessionTask.userMeTask { [weak self] (error, userMe) in
            print("userMeTask")
            let profileUrl = userMe?.profileImageURL
            let profileUrlData = try? Data(contentsOf: profileUrl!)
            let thumbnailUrl = userMe?.thumbnailImageURL
            let thumbnailUrlData = try? Data(contentsOf: thumbnailUrl!)
        
            self?.nameLabel.text = userMe?.nickname
            self?.profileImageView.image = UIImage(data: profileUrlData!)
            self?.thumbnailImageView.image = UIImage(data: thumbnailUrlData!)
        }
    }

  

}
