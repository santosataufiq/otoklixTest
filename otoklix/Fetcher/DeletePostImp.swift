//
//  DeletePostImp.swift
//  otoklix
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation

final class DeletePostImp: DeletePostUseCase {
    func delete(id: Int, result: @escaping ((Result<Void>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let urlString = "https://limitless-forest-49003.herokuapp.com/posts/\(id)"
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            URLSession.shared.dataTask(with: request) { _, response, _ in
                DispatchQueue.main.async {
                    guard let response = response as? HTTPURLResponse else {
                        result(.fail)
                        return
                    }
                    
                    if response.statusCode == 200 {
                        result(.success(()))
                    } else {
                        result(.fail)
                    }
                }
            }.resume()
        }
    }
}
