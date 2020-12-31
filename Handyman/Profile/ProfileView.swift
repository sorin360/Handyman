//
//  ProfileView.swift
//  TestApp
//
//  Created by Lica Sorin on 13/06/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

struct ProfileView: View {

    @Binding var selectedTab: String

    var body: some View {

        VStack {
            Button("Logout") {
                try! Auth.auth().signOut()
                self.selectedTab = "Users"
            }
        }

    }
}
