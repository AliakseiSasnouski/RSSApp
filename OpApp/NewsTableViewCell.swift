//
//  NewsTableViewCell.swift
//  OpApp
//
//  Created by MacBook on 08.07.17.
//  Copyright © 2017 MacBook. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var subtitleView: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageNewsView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
