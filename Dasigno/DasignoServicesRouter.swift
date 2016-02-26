//
//  DasignoServicesRouter.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static let baseURLString = "http://192.168.1.107"

    
    case Login(email: String, password: String)

    
    // MARK: URLRequestConvertible
    
    var URLRequest: NSMutableURLRequest {
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
                
                ///////////////////////////////////
                //Sign in
                ///////////////////////////////////
            case .Login(let email, let password):
                let params = ["Email": "andres.paris@dasigno.com","Password": "Temporal1"]
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





