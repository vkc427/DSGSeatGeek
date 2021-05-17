//
//  ViewController+Search.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/17/21.
//

import UIKit

extension ViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 1 {
            NSObject.cancelPreviousPerformRequests(withTarget: self,
                                                   selector: #selector(performSearch),
                                                   object: nil)
            self.perform(#selector(performSearch), with: nil, afterDelay: 0.5)
        } else if self.resultsData.event?.count != self.searchedEvent.event?.count {
            self.filterByText(searchText: "")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    @objc
    private func performSearch() {
        let searchText = self.searchBar.text ?? Messages.EmptyString
        self.filterByText(searchText: searchText)
    }
}

