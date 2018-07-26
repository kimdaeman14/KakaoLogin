

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    //앱실행되기전에 그냥 실행되는 메소드
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initalizeApp() //길어서 밑으로뺸거.
        return true
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func application(_ app: UIApplication, open url: URL, options:
        [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if KOSession.isKakaoAccountLoginCallback(url) {
            return KOSession.handleOpen(url)
        }
        return false
    }
    
    private func initalizeApp() {
        setupSessionChangedNotification()
        setupRootViewController()
    }
    
    //세션체크할때마다 노티피케이션날려주는? 알림? 체크만하는용도.
    private func setupSessionChangedNotification () {
        NotificationCenter.default.addObserver(forName: Notification.Name.KOSessionDidChange, object: nil, queue: .main) { [unowned self] (noti) in
            guard let session = noti.object as? KOSession else { return } //세션이있는지체크
            session.isOpen() ? print("Login") : print("Logout") //있으면 로그인된거고 아니면 안된거고.
            self.setupRootViewController()
        }
    }
    
    
    func setupRootViewController() {
        let stroyboard = UIStoryboard(name: "Main", bundle: nil)
        //네비게이션이 뭐로갈지모르니까 아이텐티파이어를 비워놓음 ()이렇게. 그게아니면 두개를 만들어줘야되니까.
        let navigationController = stroyboard.instantiateInitialViewController() as! UINavigationController
        
        //아래.
        //KOSession값이 열려있으면(로그인되있으면) 메인으로가고 안되있으면 로그인뷰컨트롤러로간다.
        let storyboardID = KOSession.shared().isOpen() ? "MainViewController" : "LoginViewController"
        let vc = stroyboard.instantiateViewController(withIdentifier: storyboardID)
        navigationController.viewControllers = [vc]
        window?.rootViewController = navigationController
        
        
        //        let vc: UIViewController
        //        if KOSession.shared().isOpen() {
        //            vc = stroyboard.instantiateViewController(withIdentifier: “MainViewController”) as! MainViewController
        //        } else {
        //            vc = stroyboard.instantiateViewController(withIdentifier: “LoginViewController”) as! LoginViewController
        //        }
        //        navigationController.viewControllers = [vc]
        //        window?.rootViewController = navigationController
    }
}
