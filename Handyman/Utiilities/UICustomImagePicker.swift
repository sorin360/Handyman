//
//  UICustomImagePicker.swift
//  TestApp
//
//  Created by Lica Sorin on 31/12/2020.
//  Copyright © 2020 Lica Sorin. All rights reserved.
//

import SwiftUI

struct UICustomImagePicker: UIViewControllerRepresentable {

    @Binding var isShown: Bool
    var sourceType: UIImagePickerController.SourceType

    var completionHandler: (_ image: UIImage) -> Void

    func makeCoordinator() -> Coordinator {
        return Coordinator(isShown: $isShown, completionHandler: completionHandler)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<UICustomImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<UICustomImagePicker>) {

    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var isCoordinatorShown: Bool
        var completionHandler: (_ image: UIImage) -> Void

        init(isShown: Binding<Bool>, completionHandler: @escaping (_ image: UIImage) -> Void) {
            _isCoordinatorShown = isShown
            self.completionHandler = completionHandler
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {

            guard let unwrapImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
            //let imageData: Data = unwrapImage.jpegData(compressionQuality: 0.1)!
            completionHandler(unwrapImage)
            isCoordinatorShown = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            isCoordinatorShown = false
        }
    }

}
