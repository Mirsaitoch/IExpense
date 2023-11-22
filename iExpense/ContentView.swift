//
//  ContentView.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 10.11.2023.
//

import SwiftUI


struct Item: Identifiable, Codable{
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

struct productCard: View{
    
    var item: Item
    
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

@Observable
class Expenses{
    var items = [Item](){
        didSet{
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.setValue(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decoder = try? JSONDecoder().decode([Item].self, from: savedItems){
                items = decoder
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State var expenses = Expenses()
    
    @State private var showAddPanel = false
    var body: some View {
        NavigationStack{
            List{
                Section("Personal"){
                    ForEach(expenses.items){item in
                        if item.type == "Personal"{
                            productCard(item: item)
                        }
                    }.onDelete(perform: removeItem)
                }
                Section("Business"){
                    ForEach(expenses.items){item in
                        if item.type == "Business"{
                            productCard(item: item)
                        }
                    }.onDelete(perform: removeItem)
                }
            }
            .toolbar{
                    NavigationLink{
                        AddView(expenses: expenses)
                    } label:{
                        Image(systemName: "plus")
                    }
                        
                
            }
            .navigationTitle("IExpense")
        }
    }
    
    func removeItem(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
