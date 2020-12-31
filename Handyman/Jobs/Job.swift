//
//  Job.swift
//  Handyman
//
//  Created by Lica Sorin on 31/12/2020.
//

import SwiftUI

class Job: ObservableObject {
    var id: String
    var user: String
    var imageURL: String
    var title: String?
    var description: String
    @Published var image: UIImage?

    init(id: String, user: String, image: String, title: String?, description: String) {
        self.id = id
        self.user = user
        self.imageURL = image
        self.title = title
        self.description = description
    }

    init(dictionary: [String: Any]) {
        self.id = dictionary["id"] as! String
        self.user = dictionary["user"] as! String
        self.imageURL = dictionary["imageURL"] as! String
        self.title = dictionary["title"] as? String
        self.description = dictionary["description"] as! String
    }
}


