//
//  SettingsView.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI

struct AccountTabView: View {
    // MARK: - PROPERTIES
    
    @EnvironmentObject var accountViewModel: accountViewModel

//    let appName: String = Bundle.main.infoDictionary?["CFBundleName"] as! String
//    let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 5) {
                    if accountViewModel.dataAccountIsLoading {
                        ActivityIndicator()
                            .frame(width:30, height: 30)
                            .foregroundColor(.orange)
                            .opacity(accountViewModel.dataAccountIsLoading ? 1.0 : 0.0)
                    } else {Image(accountViewModel.userData[0].profilePicture)
                            .resizable()
                            .clipShape(Circle())
                            .scaledToFit()
                            .frame(width: 200, height: 100, alignment: .center)
                            .shadow(color: Color("ColorBlackTransparentLight"), radius: 8, x: 0, y: 4)
                        Text(accountViewModel.userData[0].name)
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.bold)
                        Text(String(accountViewModel.userData[0].followers) + " Followers")
                            .font(.system(.callout, design: .rounded))
                            .fontWeight(.medium)
                        Text(String(accountViewModel.userData[0].recipeCount) + " Recipes")
                            .font(.system(.callout, design: .rounded))
                            .fontWeight(.medium)
                    }
                }
                .padding()
                
                VStack(alignment: .center, spacing: 20) {
                    
                    if accountViewModel.dataAccountIsLoading {
                        ActivityIndicator()
                           .frame(width:30, height: 30)
                           .foregroundColor(.orange)
                    } else {
                        
                        ForEach(accountViewModel.userData[0].recipes) { item in
                            RecipeCardView(recipe: item)
                        }
                    }
                }
                .frame(maxWidth: 640)
                .padding(.horizontal)
            }
//            .padding(.bottom, 160)
            
//            Form {
//                Section(header: Text("Application")) {
//                    HStack {
//                        Text("Product")
//                            .foregroundColor(Color.gray)
//                        Spacer()
//                        Text(appName)
//                    }
//                    HStack {
//                        Text("Version")
//                            .foregroundColor(Color.gray)
//                        Spacer()
//                        Text(appVersion)
//                    }
//                }
//            }
            
        }
    }
}

struct AccountTabView_Previews: PreviewProvider {
    static var previews: some View {
        AccountTabView()
            .environmentObject(accountViewModel())

    }
}
