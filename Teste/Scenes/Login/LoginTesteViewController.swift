//
//  LoginTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 10/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ResponseLoginFromURLProtocol {
    func responseLoginError(response: Error)
    func responseLoginValid(response: UserAccount)
}


class LoginTesteViewController: UIViewController, ResponseLoginFromURLProtocol {
    
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
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.isScrollEnabled = false
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
    
    func validatePassword(password: String) -> Bool {
        let up = password.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
        let regex = ".*[^A-Za-z0-9].*"
        let testString = NSPredicate(format:"SELF MATCHES %@", regex)
        let spe = testString.evaluate(with: password)
        let alpha = password.rangeOfCharacter(from: CharacterSet.alphanumerics) != nil
        return up && spe && alpha
    }
    
    func validateUser() -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: txtFieldUser.text) || txtFieldUser.text!.isCPFValid()
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
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in self.router?.routeToStatements() }))
        self.present(alert, animated: true)
        UserDefaults.standard.set(txtFieldUser.text, forKey: "Email")
    }
    
    func tryToLogin() {
        if (validateUser()) {
            guard let user = txtFieldUser.text else { return }
            guard let password = txtFieldPassword.text else { return }
            let isValid = validatePassword(password: txtFieldPassword.text ?? "")
            if isValid {
                interactor?.clickLogin(user: user, password: password)
            } else {
                let alert = UIAlertController(title: "Something wrong", message: "Invalid Password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
        } else {
            let alert = UIAlertController(title: "Something wrong", message: "Invalid User", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    //MARK: actions
    @IBAction func login(_ sender: Any) {
        tryToLogin()
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
            self.tryToLogin()
            break
        default:
            break
        }
        return true
    }
}
