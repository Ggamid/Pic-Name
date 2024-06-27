//
//  AddPerson.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import SwiftUI
import PhotosUI

struct AddPersonView: View {

    @State var viewModel = ViewModel()
    @State var photoPickerItem: PhotosPickerItem?

    @Environment(\.dismiss) var dismiss
    
    var onSave: (Person) -> Void
    
    var body: some View {
        NavigationStack{
            VStack{
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    if (viewModel.avatarImage != nil) {
                        Image(uiImage: viewModel.avatarImage!)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("tap to import photo"))
                        
                    }
                }
                .frame(height: 200)
                
                HStack{
                    Image(systemName: "pencil")
                    TextField("enter name", text: $viewModel.name)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding()
                    
                }.underlineTextField()
                
                Toggle("Add current location", isOn: $viewModel.addLocation)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
                    .onChange(of: viewModel.addLocation) { _, _ in
                        if viewModel.addLocation {
                            viewModel.locationFetcher.start()
                        }
                    }
            }
            .toolbar(content: {
                ToolbarItem {
                    Button{
                        viewModel.saveDisabled = true
                        viewModel.savePerson(onSave: onSave)

                        dismiss()
                    }label: {
                        Text("Save")
                    }
                    .disabled((viewModel.avatarImage == nil) || viewModel.name == "" || viewModel.saveDisabled)
                }
            })
        }
        .onChange(of: photoPickerItem) { _, _ in
            Task{
                if let photoPickerItem, let data = try? await photoPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        viewModel.avatarImage = image
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
