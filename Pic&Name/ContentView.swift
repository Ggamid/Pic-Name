//
//  ContentView.swift
//  Pic&Name
//
//  Created by Gamıd Khalıdov on 23.06.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSheet = false
    
    
    var body: some View {
        NavigationStack{
            List {
                
                HStack{
                    Image(.gamid)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 70)
                        .frame(width: 80)
                        .clipShape(.circle)
                    VStack(alignment:.trailing){
                        Text("Gamid")
                            .font(.headline)
                            .padding(.vertical)
                        Spacer()
                    }
                }
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
                AddPersonView()
            })
        }
    }
}

#Preview {
    ContentView()
}
