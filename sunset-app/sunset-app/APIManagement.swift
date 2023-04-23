//
//  APIManagement.swift
//  sunset-app
//
//  Created by Adrian Ma on 4/22/23.
//

import Foundation

struct ToDo: Decodable {
  let userId: Int
  let id: Int
  let title: String
  let isComplete: Bool
  
  enum CodingKeys: String, CodingKey {
    case isComplete = "completed"
    case userId, id, title
  }
}

extension URLSession {
  func fetchData(at url: URL, completion: @escaping (Result<[ToDo], Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let toDos = try JSONDecoder().decode([ToDo].self, from: data)
          completion(.success(toDos))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
