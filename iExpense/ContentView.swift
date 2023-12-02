//
//  ContentView.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 10.11.2023.
//

import SwiftUI
import SwiftData

struct productCard: View{
    
    var item: Expense
    
    var body: some View{
        HStack{
            VStack(alignment: .leading){
                Text(item.name).font(.headline)
                Text(item.type)
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(item.amount < 100.0 ? .caption :
                        (item.amount < 1000.0 && item.amount > 100.0) ? .footnote :
                        .headline
                )
        }
    }
}



struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query private var expenses: [Expense]
    @State private var showAddPanel = false
    @State private var selectedType = "All"
    var types = ["All", "Business", "Personal"]
    @State private var sortOrder = SortDescriptor(\Expense.name)

    var body: some View {
        NavigationStack{
            ExpensesView(type: selectedType, sortOrder: sortOrder)
            .toolbar{
                
                
                Menu("Sort", systemImage: "arrow.up.arrow.down") {
                    Picker("Sort", selection: $sortOrder) {
                        Text("Sort by Name")
                            .tag(SortDescriptor(\Expense.name))

                        Text("Sort by Amount")
                            .tag(SortDescriptor(\Expense.amount))
                    }
                }
                Menu("Type", systemImage: "rectangle.stack.person.crop") {
                    Picker("Sort", selection: $selectedType) {
                        Text("All")
                            .tag("All")
                        Text("Business")
                            .tag("Business")
                        Text("Personal")
                            .tag("Personal")
                    }
                }
                
                NavigationLink{
                    AddView()
                } label:{
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("IExpense")
        }
    }
}

#Preview {
    ContentView()
}
