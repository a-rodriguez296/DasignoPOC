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
    
    var viewModel:ListViewModel? = ListViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        viewModel?.didLoadItems.subscribeNext {[unowned self] (flag) -> Void in
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
            
            
            }
            .addDisposableTo(disposeBag)
        
        
        viewModel?.didPaginate.subscribeNext {[unowned self] (indexesPathsToAdd) -> Void in
            
            self.tableView.beginUpdates()
            self.tableView.insertRowsAtIndexPaths(indexesPathsToAdd, withRowAnimation: .None)
            self.tableView.endUpdates()
            
            }
            .addDisposableTo(disposeBag)
        
        NSNotificationCenter.defaultCenter()
            .addObserver(self, selector: "reloadTable:", name: "didAddTask", object: nil)
        
    }
    
    func reloadTable(notification: NSNotification){
        viewModel?.reloadTable()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let element:Element = viewModel!.tableViewItems[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath) as! CellTableViewCell
        
        
        cell.lblTitle.text = element.title
        cell.lblDescription.text = element.description
        cell.lblFrom.text = element.from
        cell.lblTo.text = element.to
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.tableViewItems.count
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == viewModel!.tableViewItems.count - 1{
            viewModel!.loadMoreTasks()
        }
    }
    
    func setupViews(){
        title = "Tasks"
        
        let navButton = UIBarButtonItem(title: "Create Task", style: .Plain, target: self, action: "createTask:")
        navigationItem.rightBarButtonItem = navButton
    }
    
    
    func createTask(sender: AnyObject){
        
        self.performSegueWithIdentifier("createTask", sender: nil)
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
