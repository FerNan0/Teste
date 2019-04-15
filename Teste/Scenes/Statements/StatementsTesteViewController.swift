//
//  StatementsTesteViewController.swift
//  Teste
//
//  Created by Fernando Duarte on 12/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class StatementsTesteViewController: UIViewController, StatementsDataStore {
    var user: UserAccount! {
        didSet {
            
        }
    }
        
    var router: (NSObjectProtocol & StatementsDataPassing)?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        router.dataStore = interactor
        viewController.router = router
    }
    
    func setHeader() {
        let user = router?.dataStore?.user
        lblName.text = user?.name
        lblAccountValue.text = formatAccount(agency: user!.agency, acc: user!.bankAccount)
        
    }
    
    func formatAccount(agency: String, acc: String) -> String {
        var accFormated = acc
        accFormated.insert(".", at: accFormated.index(accFormated.startIndex, offsetBy: 2))
        accFormated.insert(".", at: accFormated.index(accFormated.endIndex, offsetBy: -1))
        let account = agency + " / " + accFormated
        return account
    }
}

extension StatementsTesteViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        return cell
    }
}
