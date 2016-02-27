//
//  ViewController.swift
//  Dasigno
//
//  Created by Alejandro Rodriguez on 2/24/16.
//  Copyright © 2016 Alejandro Rodriguez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
    
    var viewModel:ViewModel?
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ViewModel(email: txtEmail.rx_text.asDriver(), password: txtPassword.rx_text.asDriver(), buttonTapped: btnEntrar.rx_tap.asDriver())
        
        viewModel?.combinedValidatedFileds.drive(btnEntrar.rx_enabled).addDisposableTo(disposeBag)
        viewModel?.loginOperation
            .drive(onNext: {[unowned self] (response) -> Void in
                
                switch response{
                case .Success:
                    self.performSegueWithIdentifier("tabla", sender: nil)
                    break
                case .InvalidUser(message: let message):
                    self.showAlertWithMessage(message)
                case .Failure:
                    break
                }
                
                }, onCompleted: nil, onDisposed: nil)
            .addDisposableTo(disposeBag)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSignIn(sender: AnyObject) {
        //        viewModel.didPressSignIn(txtEmail.text!, password: txtPassword.text!)
    }
    
    func showAlertWithMessage(message: String){
        
        let alertController = UIAlertController(title: "Atención", message: message, preferredStyle: .Alert)
        let alertAction = UIAlertAction(title: "Ok", style: .Cancel) {[unowned self] (action) -> Void in
            self.txtPassword.text = ""
        }
        alertController.addAction(alertAction)
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}

