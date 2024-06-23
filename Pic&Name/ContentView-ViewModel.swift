//
//  ContentView-ViewModel.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import Foundation


extension ContentView {
    @Observable
    class ViewModel {
        private(set) var persons: [Person]
        
        // TODO: перевести картинку в Data затем сохранить в JSON
        func save(){
            do{
                
            }
        }
        // TODO: Распарсить картинку из Дата и сделать список [Person]
        init(persons: [Person]) {
            self.persons = persons
        }
        
    }
}
