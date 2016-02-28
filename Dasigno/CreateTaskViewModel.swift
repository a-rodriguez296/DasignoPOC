//
//  CreateTaskViewModel.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/27/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import RxCocoa
import RxSwift

class CreateTaskViewModel{
    
    let combinedValidateFields: Driver<Bool>
    let createTaskOperation: Driver<Bool>
    
    let disposeBag = DisposeBag()
    
    init(title:Driver<String>, description: Driver<String>, date: Driver<NSDate>, buttonTapped: Driver<Void>){
        
        combinedValidateFields = Driver.combineLatest(title, description, resultSelector: { (title, description) -> Bool in
            return title.characters.count > 3 && description.characters.count > 3
        })
        
        
        let combinedFields = Driver.combineLatest(title, description, date) {
            return ($0,$1, $2)
        }
        
        
        createTaskOperation = buttonTapped.withLatestFrom(combinedFields).flatMapLatest { (title, description, date) -> Driver<Bool> in
            return DasignoApiClient.sharedInstance.createTask(title, description: description, date: date).asDriver(onErrorJustReturn: false)
        }
    }
    
}
