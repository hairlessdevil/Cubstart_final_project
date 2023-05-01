//
//  FavoritesView.swift
//  RecipeApp
//
//  Created by mt on 13.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI
import FirebaseFirestore
import FirebaseCore

let db = Firestore.firestore()

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
    @State var rating = ""
    @State var serves = ""
    @State var prep = ""
    @State var cooking = ""
    @State var ingredients = ""//["", "", "", "", "", "", "", "", "", ""]
    @State var allergy = ""
    @State var instructions = ""
    @State var cover_photo = ""
    @State var comments = ""
    @State var isEditorChoice: Bool = false
    @State var isPopover: Bool = false
    
    //FirebaseApp.configure()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .center, spacing: 15) {
                    Group{
                        HStack{
                            Text("recipe name:")
                            TextField(text: $recipe_name, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("rating:")
                            TextField(text: $rating, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("serves of people:")
                            TextField(text: $serves, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("preparation time:")
                            TextField(text: $prep, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("cooking time:")
                            TextField(text: $cooking, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("ingredients:")
                            TextField(text: $ingredients, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                                //for i in 1...10{
                                //TextField(text: $ingredients[i], prompt: Text("required")){}
                                //    .textFieldStyle(.roundedBorder)
                                //}
                        }
                        HStack{
                            Text("allergy:")
                            TextField(text: $allergy, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
                        HStack{
                            Text("instructions:")
                            TextField(text: $instructions, prompt: Text("required")){}
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
                    }
                    Group{
                        HStack{
                            Text("Cover Photo:")
                            TextField(text: $cover_photo, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
//                            Button("upload here"){}
//                                .buttonStyle(.bordered)
                        }
                        
                        HStack{
                            Text("author's comment:")
                            TextField(text: $comments, prompt: Text("required")){}
                                .textFieldStyle(.roundedBorder)
                        }
//                        Toggle(isOn: $isEditorChoice){
//                            Text("Is this recipe Editor's Choice?")
//                        }
                        .padding(.bottom, 50.0)
                        
                        Button(action: {
                            create_recipe(db: db, recipe_name: recipe_name, comments: comments, image: cover_photo, rating: Int(rating)!, serves: Int(serves)!, preparation: Int(prep)!, cooking: Int(cooking)!, instructions: [instructions], ingredients: [ingredients], isEditorChoice: true)
                            isPopover.toggle()
                        }){
                            Text("Submit!")
                        }
                        .buttonStyle(RoundedRectangleYellowButtonStyle())
                        .sheet(isPresented: $isPopover){
                                Text("Successfully uploaded your recipe!")
                            }
                    }
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

func create_recipe(db: Firestore, recipe_name: String, comments: String, image: String, rating: Int, serves: Int, preparation: Int, cooking: Int, instructions: [String], ingredients: [String], isEditorChoice: Bool){
    //let recipe_col = db.collection("Recipes")
    
    let id: String = UUID().uuidString
    let recipe: Recipe = Recipe(
        title: recipe_name,
        comments: comments,
        image: image,
        rating: rating,
        serves: serves,
        //allergy
        preparation: preparation,
        cooking: cooking,
        instructions: instructions,
        ingredients: ingredients,
        isEditorChoice: isEditorChoice
      )
    
    do{
        try db.collection("Recipes").document(id).setData(from: recipe)
    }catch let error{
        print("Error")
    }
}


struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
            .environmentObject(FavoriteViewModel())   
    }
}
