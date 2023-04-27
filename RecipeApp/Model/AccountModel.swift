//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI

// MARK: - ACCOUNT MODEL

struct Account: Identifiable, Codable, Equatable {
    var id = UUID()
    var name: String
    var followers: Int
    var recipeCount: Int
    var recipes: [Recipe]
    var profilePicture: String
    var isUser: Bool
}
