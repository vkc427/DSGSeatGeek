//
//  ViewController.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/12/21.
//

import UIKit

class ViewController: UITableViewController {
    var resultsData = Events()
    var strImage: String!
    var currentSearchTxt: String?
    var searchedEvent = Events()
    var searching = false
    @IBOutlet var searchBar: UISearchBar!
    var loadEvent: (() -> Void)?
    var arrayFav: [Int] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEvent = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        self.searchBar.delegate = self
        getEventInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }
    
    func getEventInfo() {
        //tried to avoid third party, with more time i can add the MBProgressHUD which would easily show the acitivity indicator for API calls.
        EventService().getFullEventInfo { (result) in
            switch result {
            case .success(let data):
                self.resultsData = data
                self.searchedEvent = data
                self.loadEvent?()
                
            case .failure(let error):
                print(error.localizedDescription)
                self.showAlert(message: Messages.ErrorMessage)
            }
        }
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error!!!", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedEvent.event?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //can add pull to refresh with more time.
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventInfoTableViewCell") as! EventInfoTableViewCell
    
        let event = self.searchedEvent.event?[indexPath.row]
        //Basic functionality, with more time could have displayed more info and with proper labelling.
        cell.lblEventName.text = event?.name ?? Messages.Empty
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "HH:mm E, d MMM y"
        cell.lblEventDate.text = formatter3.string(from: Helper.getDateFromAPIDateString(event?.eventDate) ?? Date())
        cell.lblEventLocation.text = event?.venue?.location ?? Messages.Empty
        self.strImage = event?.performers?.first?.image
        cell.imgEvent?.downloadedFrom(link: self.strImage)
   
        cell.btnFav.isHidden = true
        for favID in arrayFav {
            if favID == event?.id {
                cell.btnFav.isHidden = false
                cell.btnFav.tintColor = UIColor.red
            }
        }
        return cell

    }
    
    func filterByText(searchText: String) {
        currentSearchTxt = searchText
        if let searchString = self.currentSearchTxt, searchString.count > 1 {
            let filtered = resultsData.event?.filter({ events -> Bool in
                if isExist(string: events.name, searchString: searchString) || isExist(string: events.venue?.location, searchString: searchString) {
                    return true
                }
                return false
            })
            searchedEvent.event = filtered
        } else {
            searchedEvent.event = resultsData.event
        }
        self.loadEvent?()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEvent = self.searchedEvent.event?[indexPath.row]
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(identifier: "EventInfoViewController") as? EventInfoViewController {
            vc.selectedEvent = selectedEvent
            vc.arrFav = arrayFav
            vc.delegate = self
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    private func isExist(string: String?, searchString: String) -> Bool {
        return string?.range(of: searchString, options: .caseInsensitive) != nil
    }
}

extension ViewController: EventInfoViewControllerDelegate {
    func favArray(data: Array<Int>) {
        arrayFav = data
    }
}


