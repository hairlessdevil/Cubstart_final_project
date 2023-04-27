//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by mt on 15.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import Foundation

// MARK: - RECIPES DATA

final class accountViewModel: ObservableObject {
    
    @Published var dataAccountIsLoading: Bool = false
    @Published var accountData: [Account] = []
    @Published var userData: [Account] = []
    

    
    init() {
        readAllData()
    }

    func readAllData() {

//        self.dataIsLoading = true

        self.accountData = []

        self.accountData = sampleAccounts

        SearchDataManager.shared.setOriginalAccountList(list: self.accountData)

        for account in self.accountData {
            // Add if User
            if account.isUser {
                self.userData.append(account)
            }
            
            
            
            // Add editor's list if flag true
//            if account.isEditorChoice {
//                self.editorRecipesData.append(recipe)
//            }
//            // Add trendings's list if flag true
//            if recipe.isTrending {
//                self.trendingRecipesData.append(recipe)
//            }
        }

//        self.dataIsLoading = false
    }

}

