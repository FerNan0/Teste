//
//  LoginTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ResponseLoginProtocol: class {
    func responseLoginError(response: Error)
    func responseLoginValid(response: UserAccount)
}


class LoginTesteViewController: UIViewController, ResponseLoginProtocol {
    
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
        let presenter = LoginTestePresenter()
        interactor.worker = worker
        interactor.presenter = presenter
        viewController.interactor = interactor
        presenter.viewController = viewController
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
        if (validate()) {
            guard let user = txtFieldUser.text else { return }
            guard let password = txtFieldPassword.text else { return }
            interactor?.clickLogin(user: user, password: password)
        } else {
            let alert = UIAlertController(title: "Something wrong", message: "Invalid User", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func validate() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: txtFieldUser.text)
    }
    
    func responseLoginError(response: Error) {
        if let code = response.code {
        let alert = UIAlertController(title: String(format: "Error Code: %d", code), message: response.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    func responseLoginValid(response: UserAccount) {
        let alert = UIAlertController(title: "Bem-vindo", message: response.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


