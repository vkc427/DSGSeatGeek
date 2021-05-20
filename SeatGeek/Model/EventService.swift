//
//  EventService.swift
//  SeatGeek
//
//  Created by Karthik Vadlamudi on 5/14/21.
//

import Foundation
import UIKit

class EventService {
    func getFullEventInfo(completion: @escaping (Result<Events, Error>) -> Void) {
        if Reachability.isConnectedToNetwork() {
            guard let url = URL(string: "\(EventURLs.kAPI_EventAPI)\(Auth.ClientID)") else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error.localizedDescription as! Error))
                }
                if let data = data {
                    let jsonDecoder = JSONDecoder()
                        do {
                            let parsedJSON = try jsonDecoder.decode(Events.self, from: data)
                            completion(.success(parsedJSON))
                            
                        } catch {
                            print(error)
                        }
                }
            }.resume()
        } else {
            //can display a error message. 
        }
       
    }
    
}



