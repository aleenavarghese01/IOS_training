//
//  ContentView.swift
//  iTour
//
//  Created by Aleena Varghese on 30/10/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query var destionations: [Destination]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        NavigationStack{
            List{
                ForEach(destionations){ destination in
                    VStack(alignment: .leading){
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .navigationTitle("iTour")
            .toolbar{
                Button("add", action: addSamples)
            }
        }
    }
        func addSamples(){
            let india = Destination(name: "India")
            let china = Destination(name: "China")
            let pakisthan = Destination(name: "Pakisthan")
            
            modelContext.insert(india)
            modelContext.insert(pakisthan)
            modelContext.insert(china)
        }
    }


#Preview {
    ContentView()
}
