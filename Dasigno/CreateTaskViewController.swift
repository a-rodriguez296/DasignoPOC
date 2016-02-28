//
//  CreateTaskViewController.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/27/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CreateTaskViewController: UIViewController {
    
    @IBOutlet weak var lblTaskTitle: UITextField!
    @IBOutlet weak var txtTaskDescription: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var btnSendTask: UIButton!
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let viewModel = CreateTaskViewModel(
            title: lblTaskTitle.rx_text.asDriver(),
            description: txtTaskDescription.rx_text.asDriver(),
            date: datePicker.rx_date.asDriver(),
            buttonTapped: btnSendTask.rx_tap.asDriver())
        
        viewModel.combinedValidateFields.drive(btnSendTask.rx_enabled)
            .addDisposableTo(disposeBag)
        
        
        viewModel.createTaskOperation.driveNext {[unowned self] (reponse) -> Void in
            
            NSNotificationCenter.defaultCenter().postNotificationName("didAddTask", object: self, userInfo: nil)
            self.dismissViewControllerAnimated(true, completion: nil)
            }
            .addDisposableTo(disposeBag)
    }
    
}
