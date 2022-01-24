//
//  LoadPostImp.swift
//  otoklix
//
//  Created by harrie yusuf on 22/01/22.
//

import Foundation

final class LoadPostImp: LoadPostUseCase {
    func load(result: @escaping ((Result<[Post]>) -> Void)) {
        DispatchQueue.global(qos: .background).async {
            let urlString = "https://limitless-forest-49003.herokuapp.com/posts"
            guard let url = URL(string: urlString) else {
                DispatchQueue.main.async {
                    result(.fail)
                }
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    DispatchQueue.main.async {
                        result(.fail)
                    }
                    return
                }
                
                do {
                    let posts = try JSONDecoder().decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        result(.success(posts))
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
