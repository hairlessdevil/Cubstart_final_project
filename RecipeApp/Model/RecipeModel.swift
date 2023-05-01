//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI
import FirebaseFirestoreSwift

// MARK: - RECIPE MODEL

struct Recipe: Identifiable, Codable, Equatable {
    var id = UUID()
    //var author: Account
    var title: String
    var comments: String
    var image: String
    var rating: Int
    var serves: Int
    var preparation: Int
    var cooking: Int
    var instructions: [String]
    var ingredients: [String]
    var isEditorChoice: Bool
    
    enum CodingKeys: String, CodingKey{
        case id
        case title
        case comments
        case image
        case rating
        case serves
        case preparation
        case cooking
        case instructions
        case ingredients
        case isEditorChoice
    }
}
