//
//  APIService.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class APIService {
    static func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: [String: Any]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let body = body {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                print("Error serializing JSON body:", error)
                completion(.failure(error))
                return
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let noDataError = NSError(domain: "APIService", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(noDataError))
                return
            }

            print("RAW RESPONSE:", String(data: data, encoding: .utf8) ?? "Unable to print response")

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                print("DECODING ERROR:", error)
                completion(.failure(error))
            }
        }

        task.resume()
    }
}
