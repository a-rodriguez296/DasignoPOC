//
//  DasignoServicesRouter.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://190.93.157.245"

    
    case Login(email: String, password: String)

    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
                
                ///////////////////////////////////
                //Sign in
                ///////////////////////////////////
            case .Login(let email, let password):
                let params = ["Email": email,"Password": password]
                return ("/Home/VerifyIdentity", params)
               
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        URLRequest.HTTPMethod = "POST"
        let encoding = Alamofire.ParameterEncoding.JSON
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
}

enum RouterGet: URLRequestConvertible{
    
    static let baseURLString = "http://190.93.157.245"
    
    case GetElements(index: Int)
    
    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
                
                
            case .GetElements(let index):
                let params = ["CurrentPage": index,"Mailbox": 7, "NextPage":false, "Order": 0, "SearchValue": ""]
                return ("/Home/VerifyIdentity", params as? [String : AnyObject])
                
                
            }
        }()
        
        let URL = NSURL(string: Router.baseURLString)!
        let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        let encoding = Alamofire.ParameterEncoding.URL
        
        return encoding.encode(URLRequest, parameters: result.parameters).0
    }
    
    
}





