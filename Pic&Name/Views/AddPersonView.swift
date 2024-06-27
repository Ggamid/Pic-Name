//
//  AddPerson.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {
    
    @State var photoPickerItem: PhotosPickerItem?
    @State var avatarImage: UIImage?
    
    @State var name: String = ""
    @State var saveDisabled = false
    @State var addLocation = false
    
    let locationFetcher = LocationFetcher()
    
    @Environment(\.dismiss) var dismiss
    
    var onSave: (Person) -> Void
    
    var body: some View {
        NavigationStack{
            VStack{
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    if (avatarImage != nil) {
                        Image(uiImage: avatarImage!)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("tap to import photo"))
                        
                    }
                }
                .frame(height: 200)
                
                HStack{
                    Image(systemName: "pencil")
                    TextField("enter name", text: $name)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding()
                    
                }.underlineTextField()
                
                Toggle("Add current location", isOn: $addLocation)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                    .onChange(of: addLocation) { _, _ in
                        if addLocation {
                            locationFetcher.start()
                        }
                    }
            }
            .toolbar(content: {
                ToolbarItem {
                    Button{
                        
                        saveDisabled = true
                        
                        
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

                        dismiss()
                        
                    }label: {
                        Text("Save")
                    }
                    .disabled((avatarImage == nil) || name == "" || saveDisabled)

                }
            })
            
        }
        .onChange(of: photoPickerItem) { _, _ in
            Task{
                if let photoPickerItem, let data = try? await photoPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        avatarImage = image
                    }
                }
            }
        }
    }
    
    init(onSave: @escaping (Person) -> Void) {
        self.onSave = onSave
    }
}

#Preview {
    AddPersonView{ _ in }
}
