//
//  ReviseTVCell.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/3/8.
//

import UIKit

class ReviseTVCell: UITableViewCell {

    @IBOutlet weak var topic_Rev: UITextField!
    @IBOutlet weak var date_Rev: NSLayoutConstraint!
    @IBOutlet weak var phone_Rev: UITextField!
    @IBOutlet weak var pecple_Rev: UITextField!
    @IBOutlet weak var btn_Rev: UIButton!
    @IBOutlet weak var meg_Rev: UITextView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
