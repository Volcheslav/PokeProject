import Foundation

class NetworkManager {
    let sem = DispatchSemaphore.init(value: 0)
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            defer { self.sem.signal() }
            completion(data, error)
        }
        task.resume()
        sem.wait()
    }
}
