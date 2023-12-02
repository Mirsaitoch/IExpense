//
//  Expenses.swift
//  iExpense
//
//  Created by Мирсаит Сабирзянов on 02.12.2023.
//

import Foundation
import SwiftData


@Model
class Expense{
    let name: String
    let type: String
    let amount: Double
    
    init(name: String, type: String, amount: Double) {
        self.name = name
        self.type = type
        self.amount = amount
    }
    
}
