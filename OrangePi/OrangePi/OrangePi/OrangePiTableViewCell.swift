//
//  OrangePiTableViewCell.swift
//  OrangePi
//
//  Created by edward on 8/30/14.
//  Copyright (c) 2014 edwardsharp. All rights reserved.
//

import UIKit

class OrangePiTableViewCell: UITableViewCell {

  
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet weak var labelTop: UILabel!
    @IBOutlet weak var labelBottom: UILabel!
    
//    init(style: UITableViewCellStyle, reuseIdentifier: String) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//    }


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func cellForRowAtIndexPath

}
