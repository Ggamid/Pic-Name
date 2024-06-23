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
    
    @Environment(\.dismiss) var dismiss
    
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
                }.underlineTextField()
            }
            .toolbar(content: {
                ToolbarItem {
                    Button("Save") {
                        dismiss()
                    }.disabled((avatarImage == nil) && name != "")

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
}

#Preview {
    AddPersonView()
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
