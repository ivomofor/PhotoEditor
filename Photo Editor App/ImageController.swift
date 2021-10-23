//
//  ImageController.swift
//  Photo Editor App
//
//  Created by macbook on 2021/10/12.
//

import Foundation
import SwiftUI

class ImageController: ObservableObject {
    
    //@Published var displayedImage = UIImage(named: "testImage")
    
    @Published var originalImage = UIImage(named: "testImage") {
        didSet {
            displayedImage = originalImage
            thumbnailImage = originalImage?.compressed()
        }
    }
    @Published var displayedImage = UIImage(named: "testImage")
   var thumbnailImage = UIImage(named: "testImage")?.compressed()
    
    func saveImage(){
        UIImageWriteToSavedPhotosAlbum(displayedImage!,nil,nil,nil)
    }
    
    func generateFilteredImage(inputImage: UIImage, filter: FilterType) -> UIImage {
        let context = CIContext(options: nil)
        let unprocessedImage = CIImage(image: inputImage)
        
        switch filter {
        case .Vibrance:
            let filter = CIFilter(name:"CIVibrance")
                filter?.setValue(unprocessedImage, forKey: "inputImage")
            filter?.setValue(20, forKey: "inputAmount")
            if let output = filter?.outputImage{
                if let cgimg = context.createCGImage(output, from: output.extent){
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        
        case .Mono:
            let filter = CIFilter(name:"CIPhotoEffectMono")
                filter?.setValue(unprocessedImage, forKey: "inputImage")
            if let output = filter?.outputImage{
                if let cgimg = context.createCGImage(output, from: output.extent){
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        case .Original:
            return originalImage!
        case .Sepia:
            let filter = CIFilter(name:"CISepiaTone")
                filter?.setValue(unprocessedImage, forKey: "inputImage")
            if let output = filter?.outputImage{
                if let cgimg = context.createCGImage(output, from: output.extent){
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
        default:
            return originalImage!
        }
        return originalImage!
    }
}


