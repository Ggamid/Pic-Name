//
//  DetailView.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 24.06.2024.
//

import SwiftUI

struct DetailView: View {
    
    let person: Person
    
    @State var isEditing = false
    @State var name = ""
    
    var body: some View {
        NavigationStack{
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
            }
            .navigationTitle("Detail")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isEditing.toggle()
                    } label: {
                        HStack{
                            Text("Edit")
                                .font(.title2)
                            Image(systemName: "pencil")
                                .font(.system(size: 17))
                        }
                    }

                }
            }
        }
    }
    
    init(person: Person, name: String = "") {
        self.person = person
        
        _name = State(initialValue: person.name)
    }
}

#Preview {
    DetailView(person: Person.example)
}
