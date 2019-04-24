//
//  HeaderViewCell.swift
//  Teste
//
//  Created by Fernando Duarte on 16/04/19.
//  Copyright © 2019 Fernando Duarte. All rights reserved.
//

import UIKit

class HeaderViewCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel! {
        didSet {
            lblTitle.font = UIFont(name: "HelveticaNeue", size: 17)
            lblTitle.textColor = UIColor(red: 72/255, green: 84/255, blue: 101/255, alpha: 1)
            lblTitle.text = "Recentes"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
