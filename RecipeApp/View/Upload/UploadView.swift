//
//  FavoritesView.swift
//  RecipeApp
//
//  Created by mt on 13.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI

struct RoundedRectangleYellowButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    HStack {
      Spacer()
      configuration.label.foregroundColor(.white)
      Spacer()
    }
    .padding()
    .background(Color.yellow.cornerRadius(8))
    .scaleEffect(configuration.isPressed ? 0.95 : 1)
  }
}

struct UploadView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var favoriteViewModel: FavoriteViewModel
    @State var recipe_name = ""
    @State var ingredients = ""
    @State var allergy = ""
    @State var instructions = ""
    @State var cover_photo = ""
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 15) {
                    HStack{
                        Text("recipe name:")
                        TextField(text: $recipe_name, prompt: Text("required")){}
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack{
                        Text("ingredients:")
                        TextField(text: $ingredients, prompt: Text("required")){}
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(spacing: 20){ //button for more/less ingredients textfield
                        Button("+"){}
                            .buttonStyle(.bordered)
                        Button("-"){}
                            .buttonStyle(.bordered)
                    }
                    HStack{
                        Text("allergy:")
                        TextField(text: $allergy, prompt: Text("required")){}
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(spacing: 20){ //button for more/less allergy textfield
                        Button("+"){}
                            .buttonStyle(.bordered)
                        Button("-"){}
                            .buttonStyle(.bordered)
                    }
                    HStack{
                        Text("instructions:")
                        TextField(text: $ingredients, prompt: Text("required")){}
                            .textFieldStyle(.roundedBorder)
                    }
                    HStack(spacing: 20){ //button for more/less instructions textfield
                        Button("+"){}
                            .buttonStyle(.bordered)
                        Button("-"){}
                            .buttonStyle(.bordered)
                        Button("photo"){}
                            .buttonStyle(.bordered)
                    }
                    HStack{
                        Text("Cover Photo:")
                        Button("upload here"){}
                            .buttonStyle(.bordered)
                    }
                    .padding(.bottom, 50.0)
                    
                    Button("Submit!"){}
                        .buttonStyle(RoundedRectangleYellowButtonStyle())

                }
                .frame(maxWidth: 640)
                .padding(.top, 30.0)
                .padding(.horizontal)
            }
            .navigationBarTitle(Text("Upload your recipe!"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
            .environmentObject(FavoriteViewModel())   
    }
}
