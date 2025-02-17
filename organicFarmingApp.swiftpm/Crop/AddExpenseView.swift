import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var expenses: [ExpenseView.ExpenseItem]

    @State private var description = ""
    @State private var amount = ""
    @State private var selectedDate = Date()
    @State private var showDatePicker = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Expense Description
                TextField("Expense Description", text: $description)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)

                // Expense Amount
                TextField("Amount (₹)", text: $amount)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.decimalPad)
                    .padding(.horizontal, 16)

                // Date Picker Button
                Button(action: { showDatePicker.toggle() }) {
                    HStack {
                        Text("Select Date: \(formattedDate)")
                            .foregroundColor(.black)
                        Spacer()
                        Image(systemName: "calendar")
                            .foregroundColor(.green)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                }

                if showDatePicker {
                    DatePicker("", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                        .onChange(of: selectedDate) { _ in
                            showDatePicker = false // Dismiss calendar after selection
                        }
                }

                // Save Button
                Button(action: saveExpense) {
                    Text("Save Expense")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .disabled(description.isEmpty || amount.isEmpty) // Prevent saving empty expense

                Spacer()
            }
            .navigationTitle("Add Expense")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }

    // Function to format the date
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: selectedDate)
    }

    // Function to save the expense
    private func saveExpense() {
        guard let amountValue = Double(amount) else { return } // Convert amount to Double safely

        let newExpense = ExpenseView.ExpenseItem(
            description: description,
            amount: amountValue,
            date: formattedDate
        )

        expenses.append(newExpense)
        presentationMode.wrappedValue.dismiss()
    }
}
