//
//  Jobs.swift
//  Handyman
//
//  Created by Lica Sorin on 31/12/2020.
//

import SwiftUI
import Firebase

class Jobs: ObservableObject {

    @Published var posts: [Job] = []

    @Published var present = false

    init() {

        Firestore
            .firestore()
            .collection("posts")
            .addSnapshotListener { (querySnapshot, _) in
                self.posts = querySnapshot!.documents
                    .compactMap { (queryDocumentSnapshot) -> Job in
                        let post = Job(dictionary: queryDocumentSnapshot.data())
                        Storage.storage()
                            .reference(forURL: post.imageURL)
                            .getData(maxSize: 10 * 1024 * 1024) { (data, _) in
                            if let data = data {
                                post.image = UIImage(data: data)
                            }
                        }
                        return post
                }

        }

    }
}
