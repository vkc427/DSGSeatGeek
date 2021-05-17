//
//  EventInfoViewController.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/14/21.
//

import UIKit

protocol EventInfoViewControllerDelegate : NSObjectProtocol{
    func favArray(data: Array<Int>)
}

class EventInfoViewController: UIViewController {
    @IBOutlet weak var lblEventDate: UILabel!
    @IBOutlet weak var lblEventname: UILabel!
    @IBOutlet weak var imgEvent: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    var selectedEvent: EventINfo?
    var arrFav: [Int] = []
    weak var delegate : EventInfoViewControllerDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        self.lblEventname.text = selectedEvent?.name
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm E, d MMM y"
        self.lblEventDate.text = formatter3.string(from: Helper.getDateFromAPIDateString(selectedEvent?.eventDate) ?? Date())
        if let strImage = selectedEvent?.performers?.first?.image, !strImage.isEmpty {
            imgEvent?.imageFromServerURL(urlString: strImage, placeHolderImage: UIImage.init(named: "Placeholder")!)
        }
        for favID in arrFav {
            if favID == selectedEvent?.id {
                self.favButton.isSelected = true
                favButton.tintColor = UIColor.red
            }
        }
    }
    
    @IBAction func favBtnTapped(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.tintColor = UIColor.black
            sender.isSelected = false
            if let selectedItem = selectedEvent?.id, arrFav.contains(selectedItem) {
                arrFav.remove(at: arrFav.firstIndex(of: selectedItem)!)
            }
        } else {
            sender.tintColor = UIColor.red
            sender.isSelected = true
            if let selectedItem = selectedEvent?.id {
                arrFav.append(selectedItem)
            }
        }
        
        if let delegate = delegate{
            delegate.favArray(data: arrFav)
        }
    }

}
