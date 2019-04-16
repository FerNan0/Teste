//
//  StatementsTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

protocol ResponseStatementsFromURLProtocol {
    func responseStatementsError(response: Error)
    func responseStatementsValid()
}

class StatementsTesteViewController: UIViewController, StatementsDataStore, ResponseStatementsFromURLProtocol {
    
    //MARK: IBOutlets
    @IBOutlet weak var mainView: UIView! {
        didSet {
            mainView.backgroundColor = UIColor(red: 59/255, green: 73/255, blue: 238/255, alpha: 1.0)
        }
    }
    
    @IBOutlet weak var lblName: UILabel! {
        didSet {
            lblName.font = UIFont(name: "HelveticaNeue-Light", size: 30)
            lblName.textColor = .white
        }
    }
    
    @IBOutlet weak var lblAccountTitle: UILabel! {
        didSet {
            lblAccountTitle.font = UIFont(name: "HelveticaNeue", size: 12)
            lblAccountTitle.textColor = .white
            lblAccountTitle.text = "Conta"
        }
    }
    
    @IBOutlet weak var lblAccountValue: UILabel! {
        didSet {
            lblAccountValue.font = UIFont(name: "HelveticaNeue-Light", size: 30)
            lblAccountValue.textColor = .white
        }
    }
    
    @IBOutlet weak var lblBalanceTitle: UILabel! {
        didSet {
            lblBalanceTitle.font = UIFont(name: "HelveticaNeue", size: 12)
            lblBalanceTitle.textColor = .white
            lblBalanceTitle.text = "Saldo"
        }
    }
    
    @IBOutlet weak var lblBalanceValue: UILabel! {
        didSet {
            lblBalanceValue.font = UIFont(name: "HelveticaNeue-Light", size: 30)
            lblBalanceValue.textColor = .white
        }
    }
    @IBOutlet weak var btnLogout: UIButton! {
        didSet {
            self.btnLogout.setImage(UIImage(named: "logout"), for: .normal)
            self.btnLogout.tintColor = .white
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }
    
    //MARK: vars
    var user: UserAccount!
    
    var responseStatements: ResponseStatements?
    
    var router: (NSObjectProtocol & StatementsDataPassing)?
    
    var interactor: StatementsProtocol?
    
    //MARK: View lifecycle
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
        let interactor = StatementsTesteInteractor()
        let worker = StatementsTesteWorker()
        let presenter = StatementsTestePresenter()
        let router = StatementsTesteRouter()
        presenter.viewController = viewController
        interactor.worker = worker
        interactor.presenter = presenter
        router.dataStore = interactor
        router.viewController = viewController
        viewController.router = router
        viewController.interactor = interactor
    }
    
    func setupUI() {
        tableView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.5)
        tableView.separatorStyle = .none
    }
    
    func getStatements() {
        if let id = router?.dataStore?.user.userId {
            interactor?.getStatements(id: id)
        }        
    }
    
    func setHeader() {
        let user = router?.dataStore?.user
        lblName.text = user?.name
        lblAccountValue.text = formatAccount(agency: user!.bankAccount, acc: user!.agency)
        lblBalanceValue.text = self.router?.dataStore?.responseStatements?.balance.currency()
    }
    
    func formatAccount(agency: String, acc: String) -> String {
        var accFormated = acc
        accFormated.insert(".", at: accFormated.index(accFormated.startIndex, offsetBy: 2))
        accFormated.insert("-", at: accFormated.index(accFormated.endIndex, offsetBy: -1))
        let account = agency + " / " + accFormated
        return account
    }
    
    func responseStatementsError(response: Error) {
        
    }
    
    func responseStatementsValid() {
        
        DispatchQueue.main.async {
            self.setHeader()
            self.tableView.reloadData()
        }
        
    }
    
    func goToLogin() {
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginTesteViewController") as! LoginTesteViewController
        UIApplication.shared.keyWindow?.rootViewController = rootVC
    }
    
    //MARK: actions
    @IBAction func logout(_ sender: Any) {
        let alert = UIAlertController(title: "Logout", message: "Are you sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default) { action in
            self.goToLogin()
        })
        alert.addAction(UIAlertAction(title: "NO", style: .cancel))
        self.present(alert, animated: true)
    }
}

//MARK: TableView
extension StatementsTesteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.router?.dataStore?.responseStatements?.statements.count ?? 0) + 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "headerViewCell") as? HeaderViewCell
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatementsCell") as? StatementsCell
            cell?.selectionStyle = .none
            if (indexPath.row - 1) >= 0 {
                if let statement = self.router?.dataStore?.responseStatements?.statements[indexPath.row - 1] {
                    cell?.configure(statement: statement)
                }
            }
            return cell ?? UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 42.0
        }
        return 104.0
    }
}
