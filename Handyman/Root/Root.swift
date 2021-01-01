//
//  Root.swift
//  Handyman
//
//  Created by Lica Sorin on 01/01/2021.
//

import SwiftUI
import Firebase

class Root: ObservableObject {
    
    @Published var presentLogin = false
    @Published var selectedTab: String = "Users"
    
}
