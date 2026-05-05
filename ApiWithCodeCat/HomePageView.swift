//
//  HomePageView.swift
//  ApiWithCodeCat
//
//  Created by ucodesoft on 17/03/26.
//

import SwiftUI

struct HomePageView: View {
    
    var viewModel : HomePageViewModel = HomePageViewModel()
    
    var body: some View {
        ZStack {
            VStack {
             
                Button {
                    debugPrint("Get Api call")
                    viewModel.getData()
                }label: {
                 Text("Get Api")
                    .foregroundStyle(Color.red)
                }
                
                Button {
                    debugPrint("post api call")
                    viewModel.registerUser()
                }label: {
                    Text("Post Api")
                        .foregroundColor(Color.blue)
                }
                
                Button {
                    debugPrint("Get urlRequest api call")
                    viewModel.getUserUrlRequest()
                }label: {
                    Text("Get with UrlRequest")
                        .foregroundColor(Color.purple)
                }
                
                Button {
                    debugPrint("Post Api call with Encodable and JSONEncoder")
                    viewModel.registerUserWithEncodableProtocol()
                }label: {
                    Text("Post Api with Encodable and JSONEncoder")
                        .foregroundColor(Color.purple)
                }
                
                Button {
                    debugPrint("Get data and decode with decoder")
                    viewModel.getEmployeeData()
                }label: {
                    Text("Get data with Decodable")
                        .foregroundColor(Color.purple)
                }
                
                Button {
                    debugPrint("Get data with clean way")
                    viewModel.getEmployeeDataWithCleanWay()
                }label: {
                    Text("Get data with Clean way")
                        .foregroundColor(Color.purple)
                }
                
                
                
            }
        }
    }
}

#Preview {
    HomePageView()
}
