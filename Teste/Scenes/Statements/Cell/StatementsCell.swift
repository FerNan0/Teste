//
//  StatementsCell.swift
//  Teste
//
//  Created by Fernando Duarte on 15/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class StatementsCell: UITableViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var lblPaymentTitle: UILabel! {
        didSet {
            lblPaymentTitle.font = UIFont(name: "HelveticaNeue", size: 16)
            lblPaymentTitle.textColor = UIColor(red: 168/255, green: 180/255, blue: 196/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var lblPaymentName: UILabel! {
        didSet {
            lblPaymentName.font = UIFont(name: "HelveticaNeue", size: 16)
            lblPaymentName.textColor = UIColor(red: 72/255, green: 84/255, blue: 101/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var lblDate: UILabel! {
        didSet {
            lblDate.font = UIFont(name: "HelveticaNeue", size: 14)
            lblDate.textColor = UIColor(red: 168/255, green: 180/255, blue: 196/255, alpha: 1)
        }
    }
    
    @IBOutlet weak var lblValue: UILabel! {
        didSet {
            lblValue.font = UIFont(name: "HelveticaNeue", size: 20)
            lblValue.textColor = UIColor(red: 72/255, green: 84/255, blue: 101/255, alpha: 1)
        }
    }
    
    func configure(statement: Statement) {
        mainView.layer.shadowColor = UIColor.black.cgColor
        mainView.layer.shadowOpacity = 0.2
        mainView.layer.shadowOffset = CGSize.zero
        mainView.layer.cornerRadius = 6
        lblPaymentTitle.text = statement.title
        lblPaymentName.text = statement.desc
        lblDate.text = statement.date.convertDate()
        lblValue.text = statement.value.currency()
    }
}
