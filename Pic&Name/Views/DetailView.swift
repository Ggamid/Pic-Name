//
//  DetailView.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 24.06.2024.
//

import SwiftUI

struct DetailView: View {
    
    let person: Person
    @Environment(\.dismiss) var dismiss
    
    var onUpdate: (Person) -> Void
    
    @State var isEditing = true
    @State var name = ""
    @FocusState var isTypeing: Bool
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Image(
                        uiImage: AddPersonView.ViewModel.imageToUIImage(imageToConvert: person.image!)
                    )
                    .resizable()
                    .scaledToFit()
                    .clipShape(.rect(cornerRadius: 30))
                    .frame(height: 500)
                    
                    TextField(name, text: $name)
                        .disabled(isEditing)
                        .font(.title)
                        .fontWeight(.heavy)
                        .underlineTextField()
                        .padding(.horizontal)
                        .focused($isTypeing)
                }
                .navigationTitle("Detail")
                .toolbar{
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isEditing.toggle()
                            isTypeing = true
                        } label: {
                            HStack{
                                Text("Edit")
                                    .font(.title2)
                                Image(systemName: "pencil")
                                    .font(.system(size: 17))
                            }
                        }
                        
                    }
                    if person.name != name {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Save") {
                                let updatedPerson = person
                                updatedPerson.name = name
                                onUpdate(updatedPerson)
                            }
                            .font(.title2)
                        }
                    }
                }
            }
        }
    }
    
    init(person: Person, name: String = "", onUpdate: @escaping (Person) -> Void) {
        self.person = person
        self.onUpdate = onUpdate
        
        _name = State(initialValue: person.name)
    }
}

#Preview {
    DetailView(person: Person.example, onUpdate: { _ in })
}
