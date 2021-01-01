//
//  RegistrationView.swift
//  TestApp
//
//  Created by Lica Sorin on 31/12/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    
    @Binding var presentLogin: Bool
    
    @State var showCamera = false
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var image: UIImage = UIImage(systemName: "photo") ?? UIImage.init()
    
    var body: some View {
        
        Section {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .clipShape(Circle())
                .onTapGesture { showCamera.toggle() }
                .sheet(isPresented: $showCamera) {
                    UICustomImagePicker(isShown: $showCamera, sourceType: .photoLibrary) { self.image = $0 }
                }
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
        
        Section(header: Text("Name")) {
            TextField("John", text: $name)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        
        Section(header: Text("Email")) {
            TextField("John@mail.com", text: $email)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        
        Section(header: Text("Password")) {
            TextField("******", text: $password)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        
        Section {
            Button(action: {
                Auth.auth().createUser(withEmail: self.email, password: self.password) { authResult, error in
                    guard error == nil else {
                        print("Create user error: \(error!)")
                        return
                    }
                    
                    let storageRef = Storage.storage().reference().child(UUID().uuidString + ".png")
                    storageRef.putData(self.image.jpegData(compressionQuality: 0.01) ?? Data(), metadata: nil) { (_, error) in
                        guard error == nil else {
                            print("Save image: \(error!)")
                            return
                        }
                        storageRef.downloadURL { (url, error) in
                            guard let downloadURL = url?.absoluteString else {
                                print("Get download URL: \(error!)")
                                return
                            }
                            Firestore
                                .firestore()
                                .collection("users")
                                .document(authResult?.user.uid ?? "")
                                .setData(["name": self.name, "email": self.email, "imageURL": downloadURL])
                            
                            Auth.auth().signIn(withEmail: self.email, password: self.password) { _, error in
                                guard error == nil else {
                                    print("Create user error: \(error!)")
                                    return
                                }
                                self.presentLogin = false
                            }
                        }
                    }
                    
                }
                
            }
            ) {
                VStack(alignment: .center) {
                    Text("Register")
                }
                .frame(maxWidth: .infinity)
            }
        }
        .listRowBackground(Color(UIColor.systemGroupedBackground))
    }
}

