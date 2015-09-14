//
//  AgendaTableViewCell.swift
//  spdbapp
//
//  Created by tommy on 15/5/8.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

class AgendaTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lbAgenda: UILabel!

  
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblReporter: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

//        var selectedView = UIView(frame: self.frame)
//        selectedView.backgroundColor = UIColor(red: 26/255.0, green: 46/255.0, blue: 99/255.0, alpha: 0.8)
//        self.selectedBackgroundView = selectedView

    }
    
}
