import SwiftUI

struct CropDetailView: View {
    @State private var showNextScreen = false
    let crop: Crop
    @Environment(\.presentationMode) var presentationMode

    @State private var selectedSeason: String? = nil
    @State private var showSeasonPicker = false
    let seasons = ["Summer", "Winter", "Spring", "Monsoon", "Autumn"]

    @State private var selectedVariety: String? = nil
    @State private var showVarietyPicker = false
    let varieties = ["Hybrid", "Desi", "Improved", "Organic"]

    @State private var selectedDate: String?
    @State private var showDatePicker = false
    @State private var savedCrops: [Crop] = []

    var body: some View {
        VStack {
            // Header with back button
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Select Parameters")
                    .font(.headline)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))

            // Crop Image
            Image(crop.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 240)
                .clipped()
                .cornerRadius(12)
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
                .shadow(radius: 5)

            // Crop Name
            Text(crop.name)
                .font(.title)
                .bold()
                .padding(.top, 8)

            Text("Step 1 out of 2")
                .font(.subheadline)
                .foregroundColor(.green)
                .padding(.top, 4)

            VStack(spacing: 12) {
                // Select Season
                Button(action: { showSeasonPicker.toggle() }) {
                    CropSelectionRow(icon: "sun.max.fill", title: selectedSeason ?? "Please select season")
                }
                
                // Select Variety
                Button(action: { showVarietyPicker.toggle() }) {
                    CropSelectionRow(icon: "leaf.fill", title: selectedVariety ?? "Please select variety")
                }

                // Select Date
                Button(action: { showDatePicker.toggle() }) {
                    CropSelectionRow(icon: "calendar", title: selectedDate ?? "Please select sowing date")
                }
            }
            .padding()

            // Next Button
            Button(action: { showNextScreen = true }) {
                Text("Next")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Spacer()
        }
        .edgesIgnoringSafeArea(.top)
        
        // Popups for selection
        .sheet(isPresented: $showSeasonPicker) {
            SelectionPopup(title: "Select Season", options: seasons, selectedValue: $selectedSeason)
        }
        .sheet(isPresented: $showVarietyPicker) {
            SelectionPopup(title: "Select Variety", options: varieties, selectedValue: $selectedVariety)
        }
        .sheet(isPresented: $showDatePicker) {
            CalendarViewWrapper(selectedDate: $selectedDate, showDatePicker: $showDatePicker)
                .presentationDetents([.fraction(0.5)])
        }
        .sheet(isPresented: $showNextScreen) {
            CropNextScreenView(
                crop: crop,
                season: selectedSeason ?? "Unknown",
                variety: selectedVariety ?? "Unknown",
                sowingDate: selectedDate ?? "Unknown",
                onSave: { newCrop in
                    savedCrops.append(newCrop)
                    saveCrops()
                }
            )
        }
    }

    // Save crops to UserDefaults
    private func saveCrops() {
        if let encodedData = try? JSONEncoder().encode(savedCrops) {
            UserDefaults.standard.set(encodedData, forKey: "crops")
        }
    }
}

 // Selection Popup (Displays all options at once)
struct SelectionPopup: View {
    var title: String
    var options: [String]
    @Binding var selectedValue: String?
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.title2)
                .bold()
                .padding(.top, 10)

            List(options, id: \.self) { option in
                Button(action: {
                    selectedValue = option
                    dismiss()
                }) {
                    HStack {
                        Text(option)
                            .font(.body)
                            .foregroundColor(.black)
                        Spacer()
                        if selectedValue == option {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }

            Button(action: { dismiss() }) {
                Text("Cancel")
                    .foregroundColor(.green)
                    .padding()
            }
        }
        .padding()
        .presentationDetents([.medium])
    }
}

// 📌 Crop Selection Row
struct CropSelectionRow: View {
    let icon: String
    let title: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.brown)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}
