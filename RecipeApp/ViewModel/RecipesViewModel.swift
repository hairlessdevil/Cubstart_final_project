//
//  RecipeListViewModel.swift
//  RecipeApp
//
//  Created by mt on 15.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import Foundation
import FirebaseCore
import FirebaseFirestore

// MARK: - RECIPES DATA

final class RecipeListViewModel: ObservableObject {
    
    @Published var dataIsLoading: Bool = false
    @Published var dataEditorChoiceIsLoading: Bool = false
    @Published var dataTrendingIsLoading: Bool = false
    @Published var recipeData: [Recipe] = []
    @Published var editorRecipesData: [Recipe] = []
    @Published var trendingRecipesData: [Recipe] = []
    
    init() {
        for sampleRecipe in sampleRecipes{
            //let id: String = UUID().uuidString
            do{
                try db.collection("Recipes").document(sampleRecipe.id.uuidString).setData(from: sampleRecipe)
            }catch let error{
                print("Error: \(error)")
            }
        }
        readAllData()
    }
    
    func readAllData() {
        
        self.dataIsLoading = true
        self.dataEditorChoiceIsLoading = true
        //self.dataTrendingIsLoading = true
        
        self.recipeData = []
        var recipeDatas: [Recipe] = []
        let g = DispatchGroup()
        self.editorRecipesData = []
        //self.trendingRecipesData = []
        
        db.collection("Recipes").getDocuments(){(querySnapshot, err) in
            if let err = err{
                print("Error getting docs: \(err)")
            }else{
                for i in 0...querySnapshot!.documents.count-1{
                    let document = querySnapshot!.documents[i]
                    let id = document.documentID
                    let docRef = db.collection("Recipes").document(id)
                    g.enter()
                    docRef.getDocument(as: Recipe.self){result in
                        switch result{
                        case .success(let recipe):
                            SearchDataManager.shared.setOriginalList(recipe: recipe)
                            recipeDatas.append(recipe)
                            g.leave()
                        case . failure(let error):
                            print("Error: \(error)")
                            g.leave()
                        }
                        //self.recipeData = recipeDatas
//                       print("\n\n\n\n\n\n\n\(self.recipeData.count)\n\n\n\n\n\n\n")
                        
                        if i == querySnapshot!.documents.count-1{
                            self.recipeData = recipeDatas

//                            for recipe in self.recipeData {
//                                // Add editor's list if flag true
//                                if recipe.isEditorChoice {
//                                    self.editorRecipesData.append(recipe)
//                                }
//                            }

                            self.dataIsLoading = false
                            self.dataEditorChoiceIsLoading = false
                            //self.dataTrendingIsLoading = false
                        }
                    }
                }
            }
        }
        g.notify(queue: .main){
//            print("\n\n\n\n\n\n\n\n\(self.recipeData.count) goodshit\n\n\n\n")
//            print("\n\n\n\n")
            //SearchDataManager.shared.setOriginalList(list: self.recipeData)

//            for recipe in self.recipeData {
//                // Add editor's list if flag true
//                if recipe.isEditorChoice {
//                    self.editorRecipesData.append(recipe)
//                }
//            }

            self.dataIsLoading = false
            self.dataEditorChoiceIsLoading = false
            //self.dataTrendingIsLoading = false
        }
    }
    
}

