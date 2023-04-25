//
//  AppView.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI

struct AppView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image("home")
            }
            SearchView()
                .tabItem {
                    Image("search")
            }
            FavoritesView()
                .tabItem {
                    VStack{
                        Image("upload_icon")
                            .padding(.top, 10)
                        Spacer()
                    }
            }
            ShoppingListView()
                .tabItem {
                    Image("Comment")
            }
            SettingsView()
                .tabItem {
                    Image("bell")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
