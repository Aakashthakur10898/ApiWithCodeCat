//
//  HttpUtility.swift
//  ApiWithCodeCat
//
//  Created by ucodesoft on 25/03/26.
//

import Foundation

struct HttpUtility{
    
    func getApiData<T: Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T)-> Void) {
        
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if(error == nil && responseData != nil && responseData?.count != 0) {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _ = completionHandler(result)
                } catch let error {
                    debugPrint("error:\(error.localizedDescription)")
                }
            }
        }.resume()
    }
    

    //Using Async/Await version(Modern Swift)
    func getModernWay<T: Decodable>(requestUrl: URL, resultType: T.Type) async throws -> T {
       
        let (data, response)  = try await URLSession.shared.data(from: requestUrl)
        
        if let httpResponse = response as? HTTPURLResponse,  !(200...299).contains(httpResponse.statusCode) {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(T.self, from: data)
        return result
    }
    
    
    func postApiData<T: Decodable>(requestUrl: URL, requestBody: Data,  resultType: T.Type, completionHandler: @escaping(_ result: T)-> Void) {
        
        var urlRequest = URLRequest(url: requestUrl)
        urlRequest.httpMethod = "post"
        urlRequest.httpBody = requestBody
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
           
            if(data != nil && data?.count != 0) {
                do {
                    let response = try JSONDecoder().decode(T.self, from: data!)
                    _ = completionHandler(response)
                }catch let decodingError {
                    debugPrint(decodingError)
                }
            }
        }.resume()
    }
}

//Manually Decoding 
//======================================================================================================
//            do {
//                let result = try JSONDecoder().decode(UserResponse.self, from: successJsonData!)
//                debugPrint(result.data?.email)
//            }catch let error {
//                debugPrint(error)
//            }

//Success Response
let successJsonData = """
{
    "success": true,
    "data" : {
        "name": "aakash",
        "email": "codecat15@gmail.com"
    },
    "errorMessage0": "no error"
    "code": 200

}
""".data(using: .utf8)

//Failure Response
let failureJsonData = """
{
  "success" : false ,
   "data"    : "some erro occured",
   "errorMessage" : "Invalid credentials",
   "code" : 401

}
""".data(using: .utf8)

struct UserResponse: Decodable {
    let success: Bool?
    let data: User?
    let message: String?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case success, data, message, code
    }
    
    
    init(from decoder: Decoder) throws {
        //to y container kya krta hai ki y jo hmara json string hai usme s data fetch krega base on hmari coding keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.success = try container.decodeIfPresent(Bool.self, forKey: .success)
        self.data = try container.decodeIfPresent(User.self, forKey: .data)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
        self.code = try container.decodeIfPresent(Int.self, forKey: .code)
    }
}

struct User: Decodable {
    let name, email: String?
}



