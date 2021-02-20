//
//  MemberCellTableViewCell.swift
//  Note
//
//  Created by 寺西帝乃 on 2021/02/05.
//

import UIKit

class MemberIconCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usericon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(mem: Member){
//        Membername.text = mem.name as String
    }

}
