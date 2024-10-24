//
//  NetwrokManager.swift
//  H4XOR News
//
//  Created by Teja Narra on 10/23/24.
//

import Foundation

class NetwrokManager: ObservableObject {
    
    @Published var posts=[News]()
    
    func fetchData(){
        let url = URL(string: "https://hn.algolia.com/api/v1/search?tags=front_page")
        let session = URLSession(configuration: .default)
        if let url {
            let task = session.dataTask(with: url) { data, URLResponse, error in
                if error == nil{
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let response = try decoder.decode(Post.self, from: safeData)
                            DispatchQueue.main.async{
                                self.posts = response.hits
                            }
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
