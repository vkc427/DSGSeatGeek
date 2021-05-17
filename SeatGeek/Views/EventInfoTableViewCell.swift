//
//  EventInfoTableViewCell.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/14/21.
//

import UIKit

class EventInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var lblEventName: UILabel!
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventLocation: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var btnFav: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        btnFav.isHidden = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
