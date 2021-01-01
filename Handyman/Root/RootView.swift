//
//  ContentView.swift
//  Handyman
//
//  Created by Lica Sorin on 31/12/2020.
//

import SwiftUI
import Firebase

struct RootView: View {
    
   @StateObject var root = Root()
    
    var body: some View {
        NavigationView {
            TabView(selection: $root.selectedTab) {
                UsersView()
                    .tabItem {
                        Image(systemName: "person.3")
                        Text(root.selectedTab)
                    }
                    .tag("Users")
                JobsView()
                    .tabItem {
                        Image(systemName: "briefcase")
                        Text(root.selectedTab)
                    }
                    .tag("Jobs")
                (Auth.auth().currentUser == nil ?
                    AnyView(LoggedOutView(selectedTab: $root.selectedTab)):
                    AnyView(ChatsView()))
                    .tabItem {
                        Image(systemName: "message")
                        Text(root.selectedTab)
                    }
                    .tag("Chats")
                (Auth.auth().currentUser == nil ?
                    AnyView(LoggedOutView(selectedTab: $root.selectedTab)):
                    AnyView(ProfileView(selectedTab: $root.selectedTab)))
                    .tabItem {
                        Image(systemName: "person")
                        Text(root.selectedTab)
                    }
                    .tag("Profile")
            }
            .navigationBarTitle(root.selectedTab)
        }
        .navigationViewStyle(StackNavigationViewStyle())
  
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
