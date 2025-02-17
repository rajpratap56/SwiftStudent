import SwiftUI

struct ExpenseView: View {
    let crop: Crop
    @Environment(\.presentationMode) var presentationMode

    struct ExpenseItem: Identifiable {
        let id = UUID()
        let description: String
        let amount: Double
        let date: String
    }

    @State private var expenses: [ExpenseItem] = [
        ExpenseItem(description: "Fertilizers", amount: 1200, date: "15-02-2025"),
        ExpenseItem(description: "Seeds", amount: 4150, date: "10-02-2025"),
        ExpenseItem(description: "Labor", amount: 5300, date: "08-02-2025"),
        ExpenseItem(description: "Pesticides", amount: 7180, date: "05-02-2025")
    ]
    
    @State private var showAddExpense = false

    var totalExpense: Double {
        expenses.reduce(0) { total, expense in total + expense.amount }
    }

    var body: some View {
        VStack {
            // Header with Back Button
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Expenses - \(crop.name)")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))

            // Total Expense Display
            Text("Total Expense: ₹\(String(format: "%.2f", totalExpense))")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .frame(maxWidth: .infinity)
              //  .background(Color.orange)
                .cornerRadius(10)
                .padding(.horizontal)

            // Expenses List
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(expenses) { expense in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(expense.description)
                                    .font(.headline)
                                Text(expense.date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("₹\(String(format: "%.2f", expense.amount))")
                                .bold()
                                .foregroundColor(.green)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    }
                }
                .padding()
            }

            // Add Expense Button
            Button(action: {
                showAddExpense = true
            }) {
                Text("Add Expense")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 10)
        }
        .sheet(isPresented: $showAddExpense) {
            AddExpenseView(expenses: $expenses)
        }
        .navigationBarHidden(true)
    }
}
