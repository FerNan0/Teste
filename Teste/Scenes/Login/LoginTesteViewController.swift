//
//  LoginTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ValidateLoginResponseProtocol {
    func responseLoginValid(response: UserAccount)
    func showAlert(title: String, message: String, actionTitle: String)
}


class LoginTesteViewController: UIViewController, ValidateLoginResponseProtocol {
    
    //MARK: IBOutlets
    @IBOutlet weak var imgView: UIImageView!
    
    @IBOutlet weak var txtFieldUser: UITextField! {
        didSet {
            txtFieldUser.delegate = self
        }
    }
    
    @IBOutlet weak var txtFieldPassword: UITextField! {
        didSet {
            txtFieldPassword.delegate = self
        }
    }
    
    @IBOutlet weak var btnLogin: UIButton! {
        didSet {
            self.btnLogin.backgroundColor = UIColor(red: 59/255, green: 73/255, blue: 238/255, alpha: 1.0)
        }
    }

    
    
    //MARK: var
    var interactor: LoginProtocol?
    var router: (NSObjectProtocol & LoginRouting & LoginDataPassing)?    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    //MARK: functions
    func setup() {
        let viewController = self
        let interactor = LoginTesteInteractor()
        let worker = LoginTesteWorker()
        let presenter = LoginTestePresenter()
        let router = LoginTesteRouter()
        interactor.worker = worker
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
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
        
        let email = UserDefaults.standard.string(forKey: "Email") ?? ""
        txtFieldUser.text = email
    }
    
    func responseLoginValid(response: UserAccount) {        
        let alert = UIAlertController(title: "Bem-vindo", message: response.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in self.router?.routeToStatements() }))
        self.present(alert, animated: true)
        UserDefaults.standard.set(txtFieldUser.text, forKey: "Email")
    }
    
    func showAlert(title: String, message: String, actionTitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func tryToLogin(user: String, password: String) {
        if let user = txtFieldUser.text, let intrctr = interactor {
            intrctr.validateLogin(password: password, user: user)
        }
    }
    
    //MARK: actions
    @IBAction func login(_ sender: Any) {
        if let user = txtFieldUser.text, let password = txtFieldPassword.text {
            self.tryToLogin(user: user, password: password)
        }
    }
}

//MARK: textField
extension LoginTesteViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtFieldUser:
            txtFieldPassword.becomeFirstResponder()
            break
        case txtFieldPassword:
            self.view.endEditing(true)
            if let user = txtFieldUser.text, let password = txtFieldPassword.text {
                self.tryToLogin(user: user, password: password)
            }
            break
        default:
            break
        }
        return true
    }
}
