//
//  AddView.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 12.11.2023.
//

import SwiftUI

struct AddView: View {
    
    @Environment(\.dismiss) var dismiss
    var expenses: Expenses

    @State private var name = "Item"
    @State private var type = "Personal"
    @State private var amount = 0.0
    
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack{
            Form{
//                TextField("Name", text: $name)
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
                    expenses.items.append(Item(name: name, type: type, amount: amount))
                    dismiss()
                }
            }
            .navigationTitle($name)
            .toolbarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    AddView(expenses: Expenses())
}
