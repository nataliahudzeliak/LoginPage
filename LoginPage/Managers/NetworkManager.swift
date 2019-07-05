//
//  NetworkManager.swift
//  LoginPage
//
//  Created by Family on 7/4/19.
//  Copyright © 2019 Family. All rights reserved.
//

import Foundation

class NetworkManager {
    
    private static var _sharedInstance: NetworkManager! = NetworkManager()
    
    class func sharedInstance() -> NetworkManager {
        if _sharedInstance == nil {
            _sharedInstance = NetworkManager()
        }
        return _sharedInstance
    }
    private let url = "https://reqres.in/api/users/2"
    
    func getInfoAboutUser(completion: @escaping (User?, Error?) -> Void) {
        let sem = DispatchSemaphore(value: 0)
        guard let userInfoUrl = URL(string: url) else {return}
        var request = URLRequest(url: userInfoUrl)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            guard let data = data else { return }
            guard let response = response as? HTTPURLResponse,response.statusCode == 200 else {
                return
            }
            do {
                let dataAboutUser = try JSONDecoder().decode(userData.self, from: data)
                sem.signal()
                completion(dataAboutUser.data,nil)
            }
            catch {
                completion(nil,error)
            }
        }.resume()
        sem.wait(timeout: .distantFuture)
    }
}
