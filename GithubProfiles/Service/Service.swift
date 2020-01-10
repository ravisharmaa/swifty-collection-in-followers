import Foundation

struct Service {
    
    let url: String = "https://api.github.com/users/"
    
    // creating a singleton
    
    static let shared = Service()
    
    //  fetch data from external resource
    
    func fetchDataOfProfiles(_ username: String, completion: @escaping([Followers])->()) {
        
        guard let url = URL(string: url + "\(username)" + "/followers") else { return  }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else { return }
            
            do {
                let followers = try JSONDecoder().decode([Followers].self, from: jsonData)
                completion(followers)
            } catch let jsonError {
                print("Could not parse json \(jsonError)")
            }
        }.resume()
    }
    
    // fetch image from a url
    
    func fetchAvatarFrom(_ url: String, completion: @escaping(Data) -> ()) {
        
        guard let url = URL(string: url) else { return }
        
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                completion(data!)
            }
            
        }
    }
}
