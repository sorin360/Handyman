//
//  HomeView.swift
//  TestApp
//
//  Created by Lica Sorin on 13/06/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

struct JobsView: View {

    @ObservedObject var postsList = Jobs()

    var body: some View {
        VStack {
            Form {
                ForEach(postsList.posts, id: \.id) { post in
                    Section {
                        Text(post.title ?? "")
                        Text(post.description)
                        post.image != nil ? Image(uiImage: post.image!).resizable().scaledToFit() : nil
                    }
                }
            }
            Button("Add Job") {
                self.postsList.present.toggle()
            }
        }.sheet(isPresented: $postsList.present) { NewJobView() }
    }
}


