//
//  apiHelp.swift
//  football_ios
//
//  Created by Tanvir on 27/12/23.
//

import Foundation
import Combine

enum APIError: Error {
    case invalidURL
    case networkError(Error)
}

class APIService: ObservableObject {
    private let baseURL = URL(string: "https://gtvcricketlive.com")!
    let headers = [
        "ab": "rahulvai_ios_footballmaniya",
        "Content-Type": "application/json"
    ]


    func fetchData<T: Decodable>(
        endpoint: String,
      
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let url = URL(string: endpoint, relativeTo: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers

        URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw APIError.networkError(NSError(domain: "Network Error", code: 0, userInfo: nil))
                }
                
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(_): break
                    
                }
            } receiveValue: { result in
                print(result)
                completion(.success(result))
            }
            .store(in: &cancellables)
    }

    private var cancellables: Set<AnyCancellable> = []
}
