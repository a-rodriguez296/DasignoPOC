//
//  Protocols.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import RxCocoa
import RxSwift

enum LoginResult: ErrorType{
    
    case Success
    case InvalidUser(message: String)
    case Failure(message: String)
    
}

protocol DasignoApi {
    
    func login(email: String, password: String) -> Observable<LoginResult>
    func getElements(index:Int) -> Observable<[Element]>
    //func createTask(title: String, description: String, date: NSDate) -> Observable<Bool>

}
