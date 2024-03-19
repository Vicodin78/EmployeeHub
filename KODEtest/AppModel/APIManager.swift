//
//  APIManag.swift
//  KODEtest
//
//  Created by Vicodin on 15.03.2024.
//

import UIKit

class APIManager {
    
    static let shared = APIManager()
    
    let headers = ["Accept": "application/json, application/xml"]
//    let headers = [
//      "Prefer": "code=500",
//      "Accept": "application/json, application/xml"
//    ]
    
    let request = NSMutableURLRequest(url: NSURL(string: "https://stoplight.io/mocks/kode-api/trainee-test/331141861/users")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    
    func getData(completion: @escaping ([Item]) -> Void, codeResponse: @escaping (Int) -> Void) {
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        lazy var dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if let code = httpResponse?.statusCode {
                    codeResponse(code)
                }
                print(httpResponse as Any)
            }
            guard let data else {return}
            if let modelData = try? JSONDecoder().decode(ModelDataFetching.self, from: data) {
                print("Succes decoding")
                completion(modelData.items)
            } else {
                print("FAIL")
            }
                                                
        })
        dataTask.resume()
    }
}
