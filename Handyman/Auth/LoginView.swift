//
//  LoginView.swift
//  TestApp
//
//  Created by Lica Sorin on 31/12/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @Binding var presentLogin: Bool
    
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        Section(header: Text("Email")) {
            TextField("", text: $email)
        }
        
        Section(header: Text("Password")) {
            TextField("", text: $password)
        }
        Section {
            Button(action: {
                Auth.auth().signIn(withEmail: self.email, password: self.password) { _, error in
                    guard error == nil else {
                        print("Create user error: \(error!)")
                        return
                    }
                    self.presentLogin = false
                }
                
            }) {
                VStack(alignment: .center) {
                    Text("Login")
                }.frame(maxWidth: .infinity)
            }
        }.listRowBackground(Color(UIColor.systemGroupedBackground))
        
    }
}
