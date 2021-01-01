//
//  LoggedOutView.swift
//  TestApp
//
//  Created by Lica Sorin on 31/12/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

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

