//
//  UpdatePostImp.swift
//  otoklix
//
//  Created by harrie yusuf on 23/01/22.
//

import Foundation

final class UpdatePostImp: UpdatePostUseCase {
    func update(id: Int, params: [String: String], result: @escaping ((Result<Post>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let urlString = "https://limitless-forest-49003.herokuapp.com/posts/\(id)"
            
            guard let url = URL(string: urlString),
            let data = try? JSONEncoder().encode(params) else {
                DispatchQueue.main.async {
                    result(.fail)
                }
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = data
            
            URLSession.shared.dataTask(with: request) { data, _, _ in
                guard let data = data else {
                    DispatchQueue.main.async {
                        result(.fail)
                    }
                    return
                }
                
                do {
                    let post = try JSONDecoder().decode(Post.self, from: data)
                    DispatchQueue.main.async {
                        result(.success(post))
                    }
                } catch {
                    DispatchQueue.main.async {
                        result(.fail)
                    }
                }
            }.resume()
        }
    }
}
