//
//  GYTDImagePickerView.swift
//  CommerceApp
//
//  Created by Md Abdul Gafur on 10/8/23.
//


import SwiftUI
import UIKit

struct GYTDImagePickerView : UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @Binding var image: Image?
    @Binding var isPresented: Bool
    
    var onComplete:((Bool, Data?) -> Void)? = nil
    
    func makeCoordinator() -> ImagePickerViewCoordinator {
        return ImagePickerViewCoordinator(image: $image, isPresented: $isPresented,onComplete: self.onComplete)
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.allowsEditing = false
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<GYTDImagePickerView>) {
        // Nothing to update here
    }

}

func center(sourceImage:UIImage) -> UIImage {
    let sideLength = min(
        sourceImage.size.width,
        sourceImage.size.height
    )
    let originalOrientation = sourceImage.imageOrientation;
    let sourceSize = sourceImage.size
    let xOffset = (sourceSize.width - sideLength) / 2.0
    let yOffset = (sourceSize.height - sideLength) / 2.0
    
    let cropRect = CGRect(
        x: xOffset,
        y: yOffset,
        width: sideLength,
        height: sideLength
    ).integral

    let sourceCGImage = sourceImage.cgImage!
    let croppedCGImage = sourceCGImage.cropping(to: cropRect)!
    
    return UIImage(cgImage: croppedCGImage, scale: sourceImage.scale, orientation: originalOrientation)
}

final class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: Image?
    @Binding var isPresented: Bool
    var onComplete:((Bool, Data?) -> Void)? = nil
    
    init(image: Binding<Image?>, isPresented: Binding<Bool>, onComplete:((Bool, Data?) -> Void)? = nil) {
        self._image = image
        self._isPresented = isPresented
        self.onComplete = onComplete
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            let croppedCGImage:CGImage = (image.cgImage?.cropping(to: CGRect(x: 0, y: 0, width: 100, height: 200)))!
//            let croppedImage = UIImage(cgImage: croppedCGImage)
           self.image = Image(uiImage: center(sourceImage: image))
            
            if let complete = self.onComplete {
                complete(true,image.jpegData(compressionQuality: 30))
            }
        }else{
            if let complete = self.onComplete {
                complete(false,nil)
            }
        }
       
        self.isPresented = false
       
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
        if let complete = self.onComplete {
            complete(false,nil)
        }
    }
    
}
