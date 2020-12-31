//
//  AuthView.swift
//  TestApp
//
//  Created by Lica Sorin on 13/06/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

struct AuthView: View {
    
    @Binding var presentLogin: Bool
    
    @State private var option = 0
    
    var body: some View {
        Form {
            Section {
                Picker(selection: $option, label: EmptyView()) {
                    Text("Login").tag(0)
                    Text("Registration").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
            }
            .listRowBackground(Color(UIColor.systemGroupedBackground).shadow(radius: 10))
            option == 0 ? AnyView(LoginView(presentLogin: $presentLogin)) :  AnyView(RegistrationView(presentLogin: $presentLogin))
            
        }
    }
}

