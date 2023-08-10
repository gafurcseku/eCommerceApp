
//
//  OAuth2Handler.swift
//  Buddy_iOS
//
//  Created by S.M.Moinuddin on 1/1/18.
//  Copyright © 2018 S.M.Moinuddin. All rights reserved.
//

import Foundation
import Alamofire


class OAuth2Handler: RequestRetrier {
    
    var isFirstAuthenticationFailed = true
    
    public func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        if let response = request.task?.response as? HTTPURLResponse {
            guard let errorCode = DSError(rawValue: response.statusCode) else {
                isFirstAuthenticationFailed = true
                completion(false, 0.0) // don't retry
                return
            }
            switch errorCode {
            case .unauthorized:
                DLog("******** Get Access Token ********")
                completion(false, 0.0 )
                // Can't handle as WRONG Password also return this code..
                //handleUnauthorizedUser()
            case .timeOut:
                DLog("******** REQUEST TIME OUT ********")
                DLog("Retry Count = \(request.retryCount)")
                DLog("requested URL = \(String(describing: response.url))")
                if request.retryCount == 3 { completion(false, 0.0 ); return}
                completion(true, 1.0) // retry after 1 second
            case .invalidParam:
                DLog("************ ============ ************")
                DLog("******* WRONG PARAMETER SEND TO API *******")
                completion(false, 0.0 )
            case .notFound:
                DLog("************ ============ ************")
                DLog("******* NOT FOUND IN SERVER *******")
                completion(false, 0.0 )
            case .serverProblem:
                DLog("************ ============ ************")
                DLog("******* BACKEND INTERNAL SERVER PROBLEM *******")
                completion(false, 0.0 )
            case .preconditioned:
                DLog("************ ============ ************")
                DLog("******* PRE CONDITION FAILED *******")
                completion(false, 0.0 )
            }
            
        } else {
            isFirstAuthenticationFailed = true
            completion(false, 0.0) // don't retry
        }
    }

    
//    private func handleUnauthorizedUser() {
//        DispatchQueue.main.async { [weak self] in
////            guard let kWindow = UIApplication.shared.keyWindow else {return}
////            guard let topVC = kWindow.visibleViewController() else {return}
////            if topVC.isKind(of: BILoginVC.self) {
////                DLog("Already In Prelogin Controller")
////                return
////            }
//            Helper.setLoggedIn(to: false)
//            self?.goToLogin()
//        }
//    }
    
//    private func goToLogin() {
//
//        let alertController = UIAlertController(title: "Session Expired", message: "please login again", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "Okay", style: .destructive) { (action) in
//            DispatchQueue.main.async {
//                Helper.setLoggedIn(to: false)
//                self.isFirstAuthenticationFailed = true
//
//                let sb = UIStoryboard(storyboard: .login)
//                let vc = sb.instantiateViewController(withIdentifier: BILoginVC.self)
//                let navVC = UINavigationController(rootViewController: vc)
//
//                let transition = CATransition()
//                transition.type = CATransitionType.fade
//                UIApplication.shared.keyWindow?.set(rootViewController: navVC, withTransition: transition)
//            }
//        }
//        alertController.addAction(okAction)
//
//        SVProgressHUD.dismiss()
//        if isFirstAuthenticationFailed {
//            isFirstAuthenticationFailed = false
//            alertController.show()
//        }
//
//
//    }
    
}








