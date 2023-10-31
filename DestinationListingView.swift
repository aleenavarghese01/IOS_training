//
//  DestinationListingView.swift
//  iTour
//
//  Created by Aleena Varghese on 31/10/23.
//

import SwiftData
import SwiftUI

struct DestinationListingView: View {
    @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse)]) var destinations: [Destination]
    @Environment(\.modelContext) var modelContext
    var body: some View {
        List{
            ForEach(destinations){ destination in
                NavigationLink(value: destination){
                    VStack(alignment: .leading){
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                    }
                }
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    init(sort: SortDescriptor<Destination>, searchString: String){
        
        _destinations = Query(filter: #Predicate {
            if searchString.isEmpty{
                return true
            }else{
                return $0.name.localizedStandardContains(searchString)
            }
        },sort: [sort])
    }
    
    func deleteDestinations( indexSet: IndexSet){
        for index in indexSet{
            let destination = destinations[index]
            modelContext.delete(destination)
            
        }
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "")
}
