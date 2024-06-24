//
//  AddPerson-ViewModel.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 24.06.2024.
//

import Foundation
import SwiftUI

extension AddPersonView {
    @Observable
    class ViewModel {
        
        static func imageToData(imageToConvert: UIImage) async throws -> Data {
            if let data = imageToConvert.pngData() {
                return data
            }
            throw ErrorWithImage.convertFailed
        }
        
        enum ErrorWithImage: Error {
            case convertFailed, deconvertFailed
        }
        
        static func imageToUIImage(imageToConvert: Data) -> UIImage {
            if let image = UIImage(data: imageToConvert) {
                return image
            } else {
                return UIImage(resource: .gamid)
            }
        }
        
        
    }
}






extension Color {
    static let darkPink = Color(red: 208 / 255, green: 45 / 255, blue: 208 / 255)
}
extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 30)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.blue)
            .padding(10)
    }
}
