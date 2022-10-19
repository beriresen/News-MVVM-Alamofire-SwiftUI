//
//  ContentViewModel.swift
//  Haberler
//
//  Created by Erdinç Ayvaz on 12.08.2022.
//

import Foundation
import Alamofire

extension HaberView{
    @MainActor class HaberViewModel: ObservableObject {
        
        @Published var showingOptions = false
        @Published var isPresentingToast = false
        @Published var toastMessage: String?
        @Published var haberler:Haberler = Haberler(articles: [])
        @Published var secilenHaber:Articles?
        @Published var isLoading = false
        @Published var alertItem: AlertItem?
        
        func getHaberler(apiMethod:Methods, category:Categories){
            isLoading = true
            
            let parameters = ["country":"tr",
                              "apiKey":Constant.apiKey,
                              "category":category.rawValue]
            
            NetworkManager.instance.fetch(HTTPMethod.get, apiMethod: apiMethod, requestModel: parameters, model: Haberler.self) { [self] result in
                
                DispatchQueue.main.async { [self] in
                    isLoading = false
                    
                    switch result {
                    case .success(let result):
                        self.haberler = result
                        
                    case .failure(let error):
                        switch error {
                        case .invalidData:
                            alertItem = AlertContext.invalidData
                            
                        case .invalidURL:
                            alertItem = AlertContext.invalidURL
                            
                        case .invalidResponse:
                            alertItem = AlertContext.invalidResponse
                            
                        case .unableToComplete:
                            alertItem = AlertContext.unableToComplete
                        }
                    }
                }
            }
        }
    }
}
