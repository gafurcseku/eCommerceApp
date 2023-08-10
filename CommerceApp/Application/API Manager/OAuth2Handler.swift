
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
               
                completion(false, 0.0 )
                // Can't handle as WRONG Password also return this code..
                //handleUnauthorizedUser()
            case .timeOut:
               
                if request.retryCount == 3 { completion(false, 0.0 ); return}
                completion(true, 1.0) // retry after 1 second
            case .invalidParam:
                
                completion(false, 0.0 )
            case .notFound:
                
                completion(false, 0.0 )
            case .serverProblem:
               
                completion(false, 0.0 )
            case .preconditioned:
                
                completion(false, 0.0 )
            }
            
        } else {
            isFirstAuthenticationFailed = true
            completion(false, 0.0) // don't retry
        }
    }

}








