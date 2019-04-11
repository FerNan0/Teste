//
//  LoginTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class LoginTesteViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtFieldUser: UITextField!
    
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    
    //MARK: var
    var interactor: loginProtocol?
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    //MARK: functions
    func setup() {
        let viewController = self
        let interactor = LoginTesteInteractor()
        let worker = LoginTesteWorker()
        interactor.worker = worker
        viewController.interactor = interactor
    }
    
    func setupUI() {
        
        self.txtFieldUser.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.txtFieldUser.frame.height))
        self.txtFieldUser.leftViewMode = UITextField.ViewMode.always
        self.txtFieldUser.layer.borderWidth = 1.0
        self.txtFieldUser.layer.cornerRadius = 4.0
        self.txtFieldUser.layer.borderColor = UIColor.lightGray.cgColor
        
        self.txtFieldPassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.txtFieldUser.frame.height))
        self.txtFieldPassword.leftViewMode = UITextField.ViewMode.always
        self.txtFieldPassword.layer.borderWidth = 1.0
        self.txtFieldPassword.layer.cornerRadius = 4.0
        self.txtFieldPassword.layer.borderColor = UIColor.lightGray.cgColor
        
        self.btnLogin.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.btnLogin.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.btnLogin.layer.shadowOpacity = 1.0
        self.btnLogin.layer.shadowRadius = 0.0
        self.btnLogin.layer.masksToBounds = false
        self.btnLogin.layer.cornerRadius = 4.0
        
    }
    
    //MARK: actions
    @IBAction func login(_ sender: Any) {
        guard let user = txtFieldUser.text else { return }
        guard let password = txtFieldPassword.text else { return }
        interactor?.clickLogin(user: user, password: password)
    }
}
