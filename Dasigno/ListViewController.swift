//
//  ListViewController.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/27/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ListViewController: UIViewController, UITableViewDelegate {

    let disposeBag = DisposeBag()
    
    let viewModel = ListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.didLoadItems.subscribeNext {[unowned self] (flag) -> Void in
            self.tableView.reloadData()
        }
        .addDisposableTo(disposeBag)
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let element:Element = viewModel.tableViewItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath) as! CellTableViewCell
        
        
        cell.lblTitle.text = element.title
        cell.lblDescription.text = element.description
        cell.lblFrom.text = element.from
        cell.lblTo.text = element.to
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tableViewItems.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        print("\(indexPath.row) \(viewModel.tableViewItems.count)")
        if indexPath.row == viewModel.tableViewItems.count - 1{
            
        }
        
        
    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        
//        let footer = tableView.dequeueReusableCellWithIdentifier("footer")
//        
//        return footer
//        
//    }



}
