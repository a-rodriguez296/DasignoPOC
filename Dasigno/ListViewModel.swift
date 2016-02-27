//
//  ListViewModel.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/27/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import RxCocoa
import RxSwift

class ListViewModel {
    
    let disposeBag = DisposeBag()
    let didLoadItems = PublishSubject<Bool>()
    var tableViewItems = [Element]()
    
    
    init(){
        
        DasignoApiClient.sharedInstance.getElements(0)
            .subscribe(onNext: {[unowned self] (response) -> Void in
                
                self.tableViewItems = response
                self.didLoadItems.on(.Next(true))
                
                }, onError: nil, onCompleted: nil, onDisposed: nil).addDisposableTo(disposeBag)
    }
    
    
}
