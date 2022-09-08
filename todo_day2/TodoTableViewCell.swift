//
//  TodoTableViewCell.swift
//  todo_day2
//
//  Created by Atsuhiro Muroyama on 2022/09/09.
//

import UIKit

class TodoTableViewCell: UITableViewCell {
    @IBOutlet var todolabel: UILabel!
    @IBOutlet var timelabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
