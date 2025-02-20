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
        let savePath = URL.documentsDirectory.appending(path: "SavedPersons")
        
        
        
        init() {
            do{
                let data = try Data(contentsOf: savePath)
                self.persons = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                self.persons = []
                print(error)
            }
        }
        
        
        func save(){
            do {
                let data = try JSONEncoder().encode(persons)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                    print("Unable to save data.")
            }
        }
        
        
        func addPerson(person: Person) {
            persons.sort()
            persons.append(person)
            save()
        }
        
        
        func updatePerson(person: Person) {
            persons.sort()
            for i in 0...persons.count-1 {
                if persons[i].id == person.id {
                    persons[i] = person
                }
            }
            save()
        }
        
        func delete(index: IndexSet) {
            persons.sort()
            persons.remove(atOffsets: index)
            save()
        }
        
        
        
        enum ErrorWithContentViewModel {
            case makeArrayOfPersonFailed
        }
        
        
        
    }
}
