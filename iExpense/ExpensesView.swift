//
//  ExpensesView.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 02.12.2023.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [Expense]

    var body: some View {
        List{
            Section("Personal"){
                ForEach(expenses){expense in
                    if expense.type == "Personal"{
                        productCard(item: expense)
                    }
                }
                .onDelete(perform: removeItem)
            }
            Section("Business"){
                ForEach(expenses){expense in
                    if expense.type == "Business"{
                        productCard(item: expense)
                    }
                }
                .onDelete(perform: removeItem)
            }
        }
    }
    
    func removeItem(at offsets: IndexSet){
        offsets.forEach { index in
            let expense = expenses[index]
            modelContext.delete(expense)
        }
    }
    
    init(type: String, sortOrder: SortDescriptor<Expense>){
        _expenses = Query(filter: #Predicate<Expense>{ expense in
            if(type == "All"){
                return true
            }
            else if(expense.type == type){
                return true
            }
            else{
                return false
            }

        }, sort: [sortOrder])
    }
}

#Preview {
    ExpensesView(type: "All",sortOrder: SortDescriptor(\Expense.name))
        .modelContainer(for: Expense.self)

}
