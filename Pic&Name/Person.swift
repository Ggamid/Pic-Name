//
//  Person.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import Foundation
import SwiftUI
import MapKit


class Person: Codable, Identifiable, Comparable{
    
    var id = UUID()
    var name: String
    var image: Data?
    var latitude: Double?
    var longitude: Double?
    
    var coordinate: CLLocationCoordinate2D? {
        if (latitude != nil) {
            return CLLocationCoordinate2D(latitude: latitude!, longitude: longitude!)
        } else {
            return nil
        }
    }
    
    init(name: String, image: UIImage) {
        
        self.name = name
        do{
            self.image = try AddPersonView.ViewModel.imageToData(imageToConvert: image)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    init(name: String, image: UIImage, latitude: Double, longitude: Double) {
        
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        do{
            self.image = try AddPersonView.ViewModel.imageToData(imageToConvert: image)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    #if DEBUG
    static let example = Person(name: "Gamid", image: UIImage(resource: .gamid), latitude: 51.501, longitude: -0.141)
    #endif
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.id == rhs.id
    }
    
}
