//
//  AboutViewModel.swift
//  Canada
//
//  Created by user on 16/02/24.
//

import Foundation
import Combine


final class AboutViewModel {
    
    
    //MARK: - Variables
    private var responseData: Rows?
    private var response: [Rows]?
    private var serviceProtocol: APIServiceProtocol
    
    init(serviceProtocol: APIServiceProtocol) {
        self.serviceProtocol = serviceProtocol
    }
    
    //MARK: - GetData
    final func getData(completion: @escaping ServiceCallback) {
        guard let url = URL(string: URLCall.about.rawValue) else { return }
        
        serviceProtocol.getAPIData(requestUrl: url, resultType: About.self) { success, data, error in
            guard let response = data else {
                return completion(false, nil, error)
            }
            if let aboutList = response as? About {
                self.response = aboutList.rows
            }
            completion(success, response, error)
        }
    }
    
    //MARK: - GetAboutList
    final func getAboutList() -> [Rows] {
        return response ?? []
    }
}

 
