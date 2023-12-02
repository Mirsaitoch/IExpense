//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 10.11.2023.
//

import SwiftUI
import SwiftData

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Expense.self)
    }
}
