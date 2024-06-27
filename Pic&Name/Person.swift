//
//  Person.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import Foundation
import SwiftUI


class Person: Codable, Identifiable, Comparable{
    
    var id = UUID()
    var name: String
    var image: Data?
    
    init(name: String, image: UIImage) {
        
        self.name = name
        do{
            self.image = try AddPersonView.ViewModel.imageToData(imageToConvert: image)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    #if DEBUG
    static let example = Person(name: "Gamid", image: UIImage(resource: .gamid))
    #endif
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        return lhs.name < rhs.name
    }
    
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.image == rhs.image && lhs.id == rhs.id
    }
    
}
