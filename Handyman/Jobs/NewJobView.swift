//
//  NewJobView.swift
//  Handyman
//
//  Created by Lica Sorin on 31/12/2020.
//

import SwiftUI
import Firebase

struct NewJobView: View {

    @Environment(\.presentationMode) var presentationMode

    @State var showCamera = false

    @State var title = ""
    @State var description = ""
    @State var image: UIImage?
    @State var imageURL = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Title", text: $title)
                    TextField("Description", text: $description)
                    image != nil ? Image(uiImage: image!).resizable().scaledToFit() : nil
                    NavigationLink(destination: UICustomImagePicker(isShown: $showCamera, sourceType: .photoLibrary) { self.image = $0 }
                        .navigationBarTitle("")
                        .navigationBarHidden(true),
                                   isActive: $showCamera, label: { Text("Upload image") })
                }
                Button("Add Post") {
                    let storageRef = Storage.storage().reference().child(UUID().uuidString + ".png")
                    storageRef.putData(self.image?.jpegData(compressionQuality: 0.1) ?? Data(), metadata: nil) { (_, error) in
                        if error != nil {
                            print(error)
                            return
                        }
                        storageRef.downloadURL { (url, error) in
                            guard let downloadURL = url?.absoluteString else {
                                print(error)
                                return
                            }

                            Firestore.firestore()
                                .collection("posts")
                                .addDocument(data: ["id": UUID().uuidString,
                                                    "title": self.title,
                                                    "description": self.description,
                                                    "imageURL": downloadURL,
                                                    "user": Auth.auth().currentUser?.uid ?? ""])

                        }

                    }
                }
            }
        }
    }
}
