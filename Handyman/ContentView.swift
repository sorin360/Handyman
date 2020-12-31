//
//  ContentView.swift
//  Handyman
//
//  Created by Lica Sorin on 31/12/2020.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @State var presentLogin = false
    
    @State var selectedTab: String = "Users"
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab) {
                UsersView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text(selectedTab)
                    }
                    .tag("Users")
                JobsView()
                    .tabItem {
                        Image(systemName: "briefcase")
                        Text(selectedTab)
                    }
                    .tag("jobs")
                (Auth.auth().currentUser == nil ?
                    AnyView(LoggedOutView(selectedTab: $selectedTab)):
                    AnyView(ChatsView()))
                    .tabItem {
                        Image(systemName: "message")
                        Text(selectedTab)
                    }
                    .tag("Chats")
                (Auth.auth().currentUser == nil ?
                    AnyView(LoggedOutView(selectedTab: $selectedTab)):
                    AnyView(ProfileView(selectedTab: $selectedTab)))
                    .tabItem {
                        Image(systemName: "person")
                        Text(selectedTab)
                    }
                    .tag("Profile")
            }
            .navigationBarTitle(selectedTab)
        }
    }
}

struct LoggedOutView: View {
    
    @State var presentLogin = false
    
    @Binding var selectedTab: String
    
    var body: some View {
        
        VStack(alignment: .center) {
            Spacer()
            Text("Ups... you are not logged in yet")
            Text("Please")
            HStack {
                Button("Login") {
                    self.presentLogin = true
                }
                Text("or")
                Button("SignUp") {
                    self.presentLogin = true
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .sheet(isPresented: $presentLogin, onDismiss: {
            selectedTab = "User"
        }) {
            AuthView(presentLogin: self.$presentLogin)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
