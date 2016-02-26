//
//  DasignoApiClient.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON

class DasignoApiClient: DasignoApi {
    
    static let sharedInstance = DasignoApiClient()
    
    
    func login(email: String, password: String) -> Observable<LoginResult>{
        
        return Observable.create({ (observer) -> Disposable in
            
            
            Alamofire.request(.POST, "http://192.168.1.107/Home/VerifyIdentity", parameters: ["Email":"andres.paris@dasigno.com","Password":"Temporal1"], encoding: Alamofire.ParameterEncoding.JSON, headers: nil)
                .responseJSON(completionHandler: { (response) -> Void in
                    
                    switch response.result{
                        
                    case .Success(let value):
                        
                        let json = JSON(value)
                        if let result = json["result"].int {
                            
                            
                            //Cookies
                            
                            if let
                                headerFields = response.response?.allHeaderFields as? [String: String],
                                URL = response.request?.URL
                            {
                                let cookies = NSHTTPCookie.cookiesWithResponseHeaderFields(headerFields, forURL: URL)
                                
                                Alamofire.Manager.sharedInstance.session.configuration.HTTPCookieStorage?.setCookies(cookies, forURL: URL, mainDocumentURL: nil)
                            }
                            
                            observer.onNext(.Success)
                            observer.onCompleted()
                            
                        }
                        else{
                            
                            observer.onError(LoginResult.invalidUser(message: "Invalid user"))
                            
                        }
                        
                    case .Failure(let error):
                        observer.onError(LoginResult.Failure(message: error.description))
                        break
                        
                    }
                })
            return NopDisposable.instance
        })
    }
    
    
    func getElements(index:Int) -> Observable<[Element]>{
        
        return Observable.create({ (observer) -> Disposable in
            
            Alamofire.request(.GET, "http://192.168.1.107/Task/Search/", parameters: ["CurrentPage": index,"Mailbox": 7, "NextPage":false, "Order": 0, "SearchValue": ""], encoding: Alamofire.ParameterEncoding.URL, headers: nil).responseJSON(completionHandler: { (response) -> Void in
                
                switch response.result{
                    
                case .Success(let value):
                    print("\(value)")
                    let json = JSON(value)
                    let elementList = ElementsList(json: json)
                    observer.onNext(elementList.elements)
                    observer.onCompleted()
                    
                case .Failure(let error):
                    print("\(error)")
                }
            })
            return NopDisposable.instance
        })
        
        
    }
    
    
}
