//
//  DetailCell.swift
//  RankList
//
//  Created by Dukhee Kang on 2018. 3. 27..
//  Copyright © 2018년 Dukhee Kang. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak var keyTitle: UILabel!
    @IBOutlet weak var valueString: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
    }

}
