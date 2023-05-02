//
//  AppView.swift
//  RecipeApp
//
//  Created by mt on 11.05.2020.
//  Copyright © 2020 S3soft. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseCore
import UIKit

struct AppView: View {
    
    @State var email = ""
    @State var password = ""
    @State var loggedIn = false
    @State var presentSheet = false
    @State var signup_email = ""
    @State var signup_password = ""
    //TODO: add a variable that tracks whether the user has successfully logged in or not
    
    init() {
        FirebaseApp.configure()
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                print(error?.localizedDescription ?? "")
            } else {
                self.loggedIn = true
                //print("success")
            }
        }
    }
    
    func signup(email: String, password: String){
        Auth.auth().createUser(withEmail: email, password: password){authResult,
            error in
            if let err = error{
                print(err.localizedDescription)
                return
            }
        }
    }
    
    var body: some View {
        //TODO: Implement an if-else to return a new view when a certain condition is met
        if self.loggedIn == false{
            VStack{
                Spacer()
                Image("foodizone_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("Welcome to FoodiZone")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.top, 50)
                Text("Sign in to continue")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                    Button(action: { login() }){
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 220, height: 60)
                            .background(Color.green)
                            .cornerRadius(15.0)
                    }
                }.padding(.horizontal)
                Spacer()
                Button(action: {presentSheet.toggle()}){
                    Text("Don't have an account? Sign up")
                        .foregroundColor(.green)
                        .padding(.bottom, 20)
                }.sheet(isPresented: $presentSheet){
                    Text("Sign up for a new account")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    VStack(spacing: 20) {
                        TextField("Email", text: $signup_email)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        SecureField("Password", text: $signup_password)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(10)
                        Button(action: { signup(email: signup_email, password: signup_password) }){
                            Text("Sign up")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 220, height: 60)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        }
                    }
                }
            }
        }
        else{
            MainPageView()
        }
    }
}

struct MainPageView: View {
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
            UploadView()
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
            AccountTabView()
                .environmentObject(accountViewModel())
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
