//
//  EditDestinationView.swift
//  iTour
//
//  Created by Aleena Varghese on 31/10/23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
    @Bindable var destination: Destination
    @State private var newSightName = ""
    var body: some View {
        Form() {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            //            TextField("date", selection: $destination.date)
            
            Section("Priority"){
                Picker("Priority", selection: $destination.priority){
                    Text("may").tag(1)
                    Text("maybe").tag(2)
                    Text("must").tag(3)
                }
                
                .pickerStyle(.segmented)
            }
            
            Section("sights"){
                ForEach(destination.sights){ Sight in
                    Text(Sight.name)
                }
                
                HStack{
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("add", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destinations")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addSight(){
        guard newSightName.isEmpty == false
        else{
            return
        }
        withAnimation{
            let sight = Sight(name: newSightName)
            destination.sights.append(sight)
            newSightName = ""
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self, configurations: config)
        let example = Destination(name: "ExampleDestination", details: "Example details  go here and will automatically expand vertically as they are edited. ")
        return EditDestinationView(destination: example)
            .modelContainer(container)
    }catch{
        fatalError("failed tot create model container. ")
    }
}
