//
//  PostView.swift
//  Growers
//
//  Created by 寺西帝乃 on 2021/02/19.
//

import UIKit

class PostView: UITableViewCell {

    @IBOutlet weak var usericon: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var objectView: UIView!
    @IBOutlet weak var viewCommentButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
