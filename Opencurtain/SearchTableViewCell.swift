//
//  SearchTableViewCell.swift
//  Opencurtain
//
//  Created by 김기현 on 2019/10/29.
//  Copyright © 2019 김기현. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet var subscribeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
