//
//  AddPerson-ViewModel.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 24.06.2024.
//

import Foundation
import SwiftUI
import PhotosUI

extension AddPersonView {
    @Observable
    class ViewModel {
        
        var name: String = ""
        var saveDisabled = false
        var addLocation = false
        var avatarImage: UIImage?
        
        let locationFetcher = LocationFetcher()
        
        static func imageToData(imageToConvert: UIImage) throws -> Data {
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
        
        func savePerson(onSave: (Person) -> Void)  {
            if addLocation {
                if let location = locationFetcher.lastKnownLocation {
                    print("Your location is \(location)")
                    let person = Person(name: name, image: avatarImage!, latitude: location.latitude, longitude: location.longitude)
                    onSave(person)
                }
            } else {
                let person = Person(name: name, image: avatarImage!)
                onSave(person)
                print("Your location is unknown")
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
