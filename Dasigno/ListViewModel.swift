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
    let didPaginate = PublishSubject<[NSIndexPath]>()
    var tableViewItems = [Element]()
    
    var lastCount = 0
    
    var paginationIndex:Int
    
    init(){
        
        paginationIndex = 0
        
        DasignoApiClient.sharedInstance.getElements(paginationIndex)
            .subscribe(onNext: {[unowned self] (response) -> Void in
                
                self.tableViewItems = response
                self.lastCount = response.count
                self.didLoadItems.on(.Next(true))
                
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    func reloadTable(){
        
        paginationIndex = 0
        lastCount = 0
        tableViewItems = [Element]()
        DasignoApiClient.sharedInstance.getElements(paginationIndex)
            .subscribe(onNext: {[unowned self] (response) -> Void in
                
                self.tableViewItems = response
                self.lastCount = response.count
                self.didLoadItems.on(.Next(true))
                
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
        
    }
    
    
    
    func loadMoreTasks(){
        paginationIndex++
        self.lastCount = tableViewItems.count
        
        
        
        DasignoApiClient.sharedInstance.getElements(paginationIndex)
            .subscribe(onNext: {[unowned self] (response) -> Void in
                
                self.tableViewItems.appendContentsOf(response)
                if self.tableViewItems.count > self.lastCount{
                    
                    //Create the new indexes to be added
                    var indexesPathsToAdd = [NSIndexPath]()
                    let numTableItems = self.tableViewItems.count - 1
                    let lastCount = self.lastCount
                    
                    for index in lastCount...numTableItems {
                        indexesPathsToAdd.append(NSIndexPath(forItem: index, inSection: 0))
                    }
                    
                    
                    self.didPaginate.on(.Next(indexesPathsToAdd))
                }
                
                
                
                
                }, onError: nil, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
}
