//
//  APIClient.swift
//  DhamakaShopping
//
//  Created by Invariant on 1/2/21.
//
//"Bearer \(token)"

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

public enum Result<T> {
    case success(T)
    case failure(ErrorResponse)
}

typealias CompletionHandler<T> = (Result<T>) -> ()
typealias CompletionHandlerWithHeaders<T> = (Result<T>, [AnyHashable : Any]?) -> ()
public typealias ErrorResponse = (Int, Data?, Error)

class APIClient {
    
    private static var privateShared : APIClient?
    
    class var shared: APIClient {
        guard let uwShare = privateShared else {
            privateShared = APIClient()
            return privateShared ?? APIClient()
        }
        return uwShare
    }
    
    class func destroy() {
        privateShared = nil
    }
    
    let sessionManager: SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForRequest = 60 //second
        configuration.timeoutIntervalForResource = 60 //second
        return SessionManager(configuration: configuration)
    }()
    
    private init() {
        sessionManager.retrier = OAuth2Handler()
    }
    
 
    
    // Cast response into a given model
    func objectAPICall<T: Mappable>(apiEndPoint: DSEndpoint,modelType: T.Type, content:[String] = ["application/json"], isToken:Bool = true, completion: @escaping CompletionHandler<T>) {
//#if DEBUG
        print(apiEndPoint.path)
        print(apiEndPoint.query)
//#endif
        
        
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding)
            .debugLog()
            .validate(statusCode: 200..<300)
            .validate(contentType: content)
            .responseObject { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    completion(Result.failure(mError))
#if DEBUG
                    print(response.response?.statusCode)
                    do{
                        let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any]
                        print("On Fail error:\(String(describing: json))")
                    }catch{ print("erroMsg") }
#endif
                }
            }
    }
    
    // Cast response into a given model
    func objectAPICallWithoutHeader<T: Mappable>(apiEndPoint: DSEndpoint,modelType: T.Type, content:[String] = ["application/json"], completion: @escaping CompletionHandler<T>) {
#if DEBUG
        print(apiEndPoint.path)
        print(apiEndPoint.query)
#endif
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding)
            .validate(statusCode: 200..<300)
            .validate(contentType: content)
            .responseObject { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    completion(Result.failure(mError))
                }
            }
    }
    
    
    //Cast response into an array of given model
    func arrayAPICall<T:Mappable>(apiEndPoint: DSEndpoint,completion: @escaping CompletionHandler<[T]>) {
#if DEBUG
        print(apiEndPoint.path)
#endif
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding)
            .validate(statusCode: 200..<300)
            .responseObject { (response: DataResponse<T>) in
                print(response)
                switch response.result {
                case .success(let value):
                    completion(Result.success(value as! [T]))
                case .failure(let error):
                   
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    completion(Result.failure(mError))
                }
            }
    }
    
    private var basicHeaders: [String:String]? {
        return ["Authorization" :  "Basic ZWxhc3RpYzpITDhDNmdRNm83aTlyYzdOdG8zODJqRjY="]
    }
    
    // Cast response into a given model
    func esSearchAPICall<T: Mappable>(apiEndPoint: DSEndpoint,modelType: T.Type, content:[String] = ["application/json"], completion: @escaping CompletionHandler<T>) {
#if DEBUG
        print(apiEndPoint.path)
        print(apiEndPoint.query)
#endif
        
        
        sessionManager.request(apiEndPoint.path, method: apiEndPoint.method, parameters: apiEndPoint.query, encoding: apiEndPoint.encoding, headers: basicHeaders )
            .validate(statusCode: 200..<300)
            .validate(contentType: content)
            .responseObject { (response: DataResponse<T>) in
                switch response.result {
                case .success(let value):
                    completion(Result.success(value))
                case .failure(let error):
                    guard let statusCode = response.response?.statusCode else {
                        let unKnownError = ErrorResponse(-999, response.data, error)
                        completion(Result.failure(unKnownError))
                        return
                    }
                    let mError = ErrorResponse(statusCode, response.data, error)
                    
                    completion(Result.failure(mError))
#if DEBUG
                    do{
                        let json = try JSONSerialization.jsonObject(with: response.data!, options: []) as? [String : Any]
                        print("On Fail error:\(String(describing: json))")
                    }catch{ print("erroMsg") }
#endif
                }
            }
    }

}


extension DataRequest {
   public func debugLog() -> Self {
      #if DEBUG
       //  debugPrint(self)
      #endif
      return self
   }
}
