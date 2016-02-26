//
//  ModelViewController.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import RxCocoa
import RxSwift

class ViewModel {
    
    var signInResponse = PublishSubject<Bool>()
    let combinedValidatedFileds: Driver<Bool>
    let loginOperation: Driver<LoginResult>
    
    
    let disposeBag = DisposeBag()
    
    init(email: Driver<String>, password: Driver<String>, buttonTapped: Driver<Void>){
    
        
        combinedValidatedFileds = Driver.combineLatest(email, password) { (email, password) -> Bool in
            
            return email.characters.count > 3 && password.characters.count > 3
        }
        
        let combinedFields = Driver.combineLatest(email, password) { (email, password) -> (String, String) in
            return (email, password)
        }
        
        
        loginOperation =  buttonTapped.withLatestFrom(combinedFields).flatMapLatest { (email, password) -> Driver<LoginResult> in
         return DasignoApiClient.sharedInstance.login(email, password: password).asDriver(onErrorJustReturn: LoginResult.Failure(message: "Invalid user"))
        }
    }
    
    
    func didPressSignIn(email: String, password: String){
        
        DasignoApiClient.sharedInstance.login(email, password: password)
            .subscribe(onNext: {[unowned self] (response) -> Void in
                self.signInResponse.on(.Next(true))
                
                
                }, onError: { (error) -> Void in
                    
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    
}
