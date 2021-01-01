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
                    .tag("Jobs")
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
        .navigationViewStyle(StackNavigationViewStyle())
  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
