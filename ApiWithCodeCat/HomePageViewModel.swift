//
//  HomePageViewModel.swift
//  ApiWithCodeCat
//
//  Created by ucodesoft on 17/03/26.
//

import Foundation

class HomePageViewModel {
 
    //Get Api data from Api with simple way
    //in this code we use Url with datatask
    
    func getData() {
        debugPrint("in get data function")
        let session = URLSession.shared
        let serviceUrl = URL(string: "https://jsonplaceholder.typicode.com/todos/1")
        
        let task = session.dataTask(with: serviceUrl!) { serviceData, serviceResponse, error in
            
            if error == nil {
                
                let httpResponse = serviceResponse as! HTTPURLResponse
                
                if (httpResponse.statusCode == 200) {
                    
                    let jsonData = try? JSONSerialization.jsonObject(with: serviceData!, options: .mutableContainers)
                    print(jsonData)
                    
                    let result = jsonData as! Dictionary<String, Any>
                    debugPrint("id = \(result["id"])")
                }
            }
        }
        task.resume()
    }
    
    //Post Api user data with simple way
    func registerUser () {
        
        var urlRequest = URLRequest(url: URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser")!)
        urlRequest.httpMethod = "post"
        
        let dataDictionary = ["name": "aakash thakur", "email": "aakash@gmail.com", "password": "12345"]
        
        do {
            //Here we convert our dataDictionary into data like binary format with help of JSONSerialization
            //becasue other system only know binary
            //THERE is two ways of doing thia one is JSONSerialization.data and second is Encodable
            let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)
            urlRequest.httpBody = requestBody
            //this step is very important we tell us server like we send data in jason type
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            
            
        }catch {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if (data != nil && data?.count != 0) {
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response)
            }
             
        }.resume()
    }
    
    //Get Api with URLRequest
    func getUserUrlRequest() {
        var urlRequest = URLRequest(url: URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/GetUser")!)
        urlRequest.httpMethod = "get"
        
        URLSession.shared.dataTask(with: urlRequest) { data, httpUrlResponse, error in
            if (data != nil && data?.count != 0) {
                let response = String(data: data!, encoding: .utf8)
                debugPrint(response)
            }
        }
        .resume()
    }
    
    
    //Post Api with Encodable Protocol
    func registerUserWithEncodableProtocol() {
        var urlRequest = URLRequest(url: URL(string: "https://api-dev-scus-demo.azurewebsites.net/api/User/RegisterUser")!)
        urlRequest.httpMethod = "post"
        
        
        let request = UserRegistrationRequest(FirstName: "Aakash", LastName: "Thakur", Email: "aakash@gmail.com", Password: "1234")
        
        do {
            //Here we convert our dataDictionary into data like binary format with help of JSONEncoder
            //becasue other system only know binary
            let requestBody = try JSONEncoder().encode(request)
            debugPrint("request Body before sending to post api = \(String(data: requestBody, encoding: .utf8))")
            
            urlRequest.httpBody = requestBody
            //this step is very important we tell us server like we send data in jason type
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            
            
        }catch {
            debugPrint(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in
            
            if (data != nil && data?.count != 0) {
                do {
                    let response = try JSONDecoder().decode(UserRegistrationResponse.self, from: data!)
                    debugPrint(response)
                }
                catch let decodingError {
                    debugPrint(decodingError)
                }
            }
             
        }.resume()
    }
    
    //Get data and decode with using Decodable and decoder
    func getEmployeeData() {
        let employeeApiUrl = "https://demo0333988.mockable.io/Employees"
        
        URLSession.shared.dataTask(with: URL(string: employeeApiUrl)!) { (responseData, httpUrlResponse, error) in
            
            if (error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(EmployeeResponse.self, from: responseData!)
                    debugPrint(result)
                } catch let error {
                    debugPrint("error occured while decoding: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    func getEmployeeDataWithCleanWay() {
      
        let objEmloyee = Employee(httpUtility: HttpUtility())
        objEmloyee.getEmployeWithCleanWay()
    }
}


struct Employee {
    
    private let httpUtility: HttpUtility
    
    init(httpUtility: HttpUtility) {
        self.httpUtility = httpUtility
    }
    
    func getEmployeWithCleanWay() {
        let employeeApiUrl = "https://demo0333988.mockable.io/Employees"
        
        httpUtility.getApiData(requestUrl: URL(string: employeeApiUrl)!,
                               resultType: [EmployeeResponse].self) { employeResult in
                      
            if(employeResult.count != 0) {
                for employe in employeResult {
                    debugPrint(employe.name)
                }
            }
        }
    }
    
    func PostAPIregisterUserWithEncodableProtocol() {

        let registrationUrl = URL(string: "https://demo0333988.mockable.io/Employees")
        
        let request = UserRegistrationRequest(FirstName: "Aakash", LastName: "Thakur", Email: "aakash@gmail.com", Password: "12345")
        
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            httpUtility.postApiData(requestUrl: registrationUrl!, requestBody:encodedRequest, resultType: UserRegistrationResponse.self) { userRegistrationResponse in
                debugPrint(userRegistrationResponse.data?.name)
            }
            
        }catch let error {
            debugPrint("error = \(error.localizedDescription)")
        }
    }
}
