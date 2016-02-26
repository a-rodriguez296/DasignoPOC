//
//  TablaViewController.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/25/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TablaViewController: UIViewController
,UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tableView: UITableView!
    
    let tableViewModel = TablaViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewModel.didLoadItems.subscribeNext {[unowned self] (response) -> Void in
            self.tableView.reloadData()
        }
        .addDisposableTo(disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let element:Element = tableViewModel.tableViewItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath) as! CellTableViewCell
        
        
        cell.lblTitle.text = element.title
        cell.lblDescription.text = element.description
        cell.lblFrom.text = element.from
        cell.lblTo.text = element.to
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.tableViewItems.count
    }


}
