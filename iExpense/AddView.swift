//
//  AddView.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 12.11.2023.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
//    @Bindable var expense: Expense

    @State private var name = "Item"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
                Picker("Type", selection: $type){
                    ForEach(types, id:\.self){ type in
                        Text(type)
                        
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currencySymbol ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .toolbar{
                Button("Save"){
                    modelContext.insert(Expense(name: name, type: type, amount: amount))
                    dismiss()
                }
            }
            .navigationTitle($name)
            .toolbarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Expense.self, configurations: config)
        let expense = Expense(name: "Apple", type: "Business", amount: 23)
        return AddView()
            .modelContainer(container)
    }
    catch{
        return Text("Error: \(error.localizedDescription)")
    }
}
