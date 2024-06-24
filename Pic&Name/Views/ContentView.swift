//
//  ContentView.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSheet = false
    
    @State var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.persons, id: \.id) { person in
                    NavigationLink {
                        DetailView(person: person, onUpdate: viewModel.updatePerson(person:))
                    } label: {
                        HStack{
                            Image(uiImage: AddPersonView.ViewModel.imageToUIImage(imageToConvert: person.image!))
                                .resizable()
                                .scaledToFill()
                                .frame(height: 70)
                                .frame(width: 80)
                                .clipShape(.circle)
                            VStack(alignment:.trailing){
                                Text(person.name)
                                    .font(.headline)
                                    .padding(.vertical)
                            }
                        }
                    }

                }
                .onDelete(perform: viewModel.delete)
            }
            .navigationTitle("Pic&Name")
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button{
                        showSheet = true
                    }label: {
                        Image(systemName: "plus.app")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                AddPersonView(onSave: viewModel.addPerson(person:))
            })
        }
    }
}

#Preview {
    ContentView()
}
