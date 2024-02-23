//
//  NetworkManager.swift
//  ClothesStore
//
//  Created by Raj 2 on 01/09/2022.
//  Copyright © 2022 RichieHope. All rights reserved.
//

import Foundation
import Combine
 



@available(iOS 13.0, *)
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let baseURL = "http://127.0.0.1:3000/"
    
    
    func getData<T: Decodable>(urlString: String, id: Int? = nil, type: T.Type) -> Future<T, Error> {
        return Future<T, Error> { [weak self] promise in
 
            guard let self = self, let url = URL(string: urlString) else {
                return promise(.failure(NetworkError.invalidURL))
            }
            print("URL is \(url.absoluteString)")
            URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                        throw NetworkError.responseError
                    }
                    return data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { value in promise(.success(value))
                    
                })
                .store(in: &self.cancellables)
        }
    }
}



extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("Invalid URL", comment: "Invalid URL")
        case .responseError:
            return NSLocalizedString("Unexpected status code", comment: "Invalid response")
        case .unknown:
            return NSLocalizedString("Unknown error", comment: "Unknown error")
        }
    }
}

@available(iOS 13.0, *)
extension URLSession {

    // 1
    enum SessionError: Error {
        case statusCode(HTTPURLResponse)
    }

    /// Function that wraps the existing dataTaskPublisher method and attempts to decode the result and publish it
    /// - Parameter url: The URL to be retrieved.
    /// - Returns: Publisher that sends a DecodedResult if the response can be decoded correctly.
    // 2
    
    func dataTaskPublisher<T: Decodable>(for url: URL) -> AnyPublisher<T, Error> {
        // 3
        return self.dataTaskPublisher(for: url)
        // 4
            .tryMap({ (data, response) -> Data in
                if let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) == false {
                    throw SessionError.statusCode(response)
                }
                
                return data
            })
        // 5
            .decode(type: T.self, decoder: JSONDecoder())
        // 6
            .eraseToAnyPublisher()
    }
}
 
