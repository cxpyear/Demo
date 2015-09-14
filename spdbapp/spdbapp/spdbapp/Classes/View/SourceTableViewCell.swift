//
//  SourceTableViewCell.swift
//  spdbapp
//
//  Created by GBTouchG3 on 15/7/9.
//  Copyright (c) 2015年 shgbit. All rights reserved.
//

import UIKit

class SourceTableViewCell: UITableViewCell {

    @IBOutlet weak var lblShowSourceFileName: UILabel!
    @IBOutlet weak var downloadProgressBar: UIProgressView!
    @IBOutlet weak var imgShowFileStatue: UIImageView!
    @IBOutlet weak var lblShowDownloadPercent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
