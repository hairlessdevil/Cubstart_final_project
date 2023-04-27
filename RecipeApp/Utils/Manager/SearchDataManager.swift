//
//  SearchDataManager.swift
//  RecipeApp
//
//  Created by muhammed on 11/12/2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import Foundation

class SearchDataManager: ObservableObject {
    
    static let shared = SearchDataManager()
    
    @Published var recipeList = [Recipe]()
    @Published var accountList = [Account]()
    
    var originalRecipeList = [Recipe]()
    var originalAccountList = [Account]()
    
    func setOriginalList(list:[Recipe]) {
        self.originalRecipeList = list
        self.recipeList = list
    }
    
    func setOriginalAccountList(list:[Account]) {
        self.originalAccountList = list
        self.accountList = list
    }
    
    func resetToOriginal() {
        if recipeList.count != originalRecipeList.count {
            recipeList = originalRecipeList
        }
        if accountList.count != originalAccountList.count {
            accountList = originalAccountList
        }
    }
    
    func setEmpty() {
        if !recipeList.isEmpty {
            recipeList.removeAll()
        }
        if !accountList.isEmpty {
            accountList.removeAll()
        }
    }
    
    func search(text: String) {
        recipeList = originalRecipeList.filter{ $0.title.lowercased().contains(text.lowercased()) }
    }
}
