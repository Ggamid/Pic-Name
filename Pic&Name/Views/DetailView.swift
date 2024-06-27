//
//  DetailView.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 24.06.2024.
//

import SwiftUI
import MapKit
struct DetailView: View {
    
    let person: Person
    @Environment(\.dismiss) var dismiss
    
    var onUpdate: (Person) -> Void
    
    let photoLocation: MapCameraPosition?
    
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
                    .frame(height: 300)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    TextField(name, text: $name)
                        .disabled(isEditing)
                        .font(.title)
                        .fontWeight(.heavy)
                        .underlineTextField()
                        .padding(.horizontal)
                        .focused($isTypeing)
                    if person.longitude != nil {
                        MapReader { proxy in
                            Map(initialPosition: photoLocation!) {
                                Annotation("", coordinate: person.coordinate!) {
                                    Image(systemName: "smallcircle.filled.circle")
                                        .foregroundStyle(.red)
                                }
                            }
                        }
                        .frame(height: 300)
                }
                    
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
        if person.latitude != nil {
            self.photoLocation = MapCameraPosition.region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: person.latitude!, longitude: person.longitude!),
                    span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5)
                )
            )
        } else {
            self.photoLocation = nil
        }
        
        _name = State(initialValue: person.name)
    }
}

#Preview {
    DetailView(person: Person.example, onUpdate: { _ in })
}
