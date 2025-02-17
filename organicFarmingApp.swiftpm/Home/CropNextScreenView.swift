import SwiftUI
struct CropNextScreenView: View {
    let crop: Crop
    let season: String
    let variety: String
    let sowingDate: String
    var onSave: (Crop) -> Void

    @Environment(\.dismiss) private var dismiss

    @State private var cropSize: String = ""
    @State private var selectedUnit: String = "Acre"
    @State private var selectedSowingMethod: String = "Select"
    @State private var selectedPlantingMaterial: String = "Select"
    @State private var selectedFarmingType: String = "Select"
    @State private var selectedIrrigationMethod: String = "Select"

    @State private var showUnitPopup = false
        @State private var showSowingMethodPopup = false
        @State private var showPlantingMaterialPopup = false
        @State private var showFarmingTypePopup = false
        @State private var showIrrigationMethodPopup = false //  State for navigation
    @State private var isShowingCropSchedule = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Text("Add Crop")
                        .font(.headline)
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding()
                .background(Color.green.opacity(0.3))
                
                ScrollView {
                    VStack(spacing: 16) {
                        // Crop Image
                        Image(crop.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                            .padding(.horizontal, 24)
                            .padding(.top, 8)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(crop.name) (\(variety))")
                                .font(.title2)
                                .bold()
                            HStack {
                                Text("Sowing date:")
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("\(sowingDate)  |  \(season)")
                                    .bold()
                            }
                        }
                        .padding(.horizontal, 24)
                        .padding(.top, 8)
                        
                        Divider()
                        
                        Text("Step 2 out of 2")
                            .font(.subheadline)
                            .foregroundColor(.green)
                            .bold()
                            .padding(.top, 8)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Farming Details")
                                .font(.title3)
                                .bold()
                                .padding(.bottom, 8)
                            
                            // Units Selection
                            
                            FarmingDetailRow(icon: "ruler.fill", title: "Units", value: selectedUnit)
                                .onTapGesture { showUnitPopup = true }
                            
                            // Crop Size (Manual Input)
                            HStack {
                                Image(systemName: "square.and.pencil")
                                    .foregroundColor(.green)
                                Text("Crop Size")
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                TextField("Enter crop size", text: $cropSize)
                                    .keyboardType(.decimalPad)
                                    .multilineTextAlignment(.trailing)
                                    .frame(width: 80)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                
                                Text(selectedUnit)
                                    .foregroundColor(.black)
                                    .bold()
                            }
                            .padding(.horizontal, 16)
                            .frame(height: 50)
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                            FarmingDetailRow(icon: "leaf.fill", title: "Sowing method", value: selectedSowingMethod)
                                .onTapGesture { showSowingMethodPopup = true }
                            
                            FarmingDetailRow(icon: "tray.full.fill", title: "Planting Material", value: selectedPlantingMaterial)
                                .onTapGesture { showPlantingMaterialPopup = true }
                            
                            FarmingDetailRow(icon: "leaf.fill", title: "Farming Type", value: selectedFarmingType)
                                .onTapGesture { showFarmingTypePopup = true }
                            
                            // Irrigation Method
                            FarmingDetailRow(icon: "drop.triangle.fill", title: "Irrigation Method", value: selectedIrrigationMethod)
                                .onTapGesture { showIrrigationMethodPopup = true }
                            
                        }
                        .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 80)
                }
                
                VStack {
                    Divider()
                    
                        .fullScreenCover(isPresented: $isShowingCropSchedule) {  //  Fullscreen modal
                            CropScheduleView(crop: crop, sowingDate: sowingDate, closingDate: "30/05/2025")
                        }
                    
                    Button(action: {
                        let newCrop = Crop(
                            id: crop.id,
                            name: crop.name,
                            variety: variety,
                            date: sowingDate,
                            season: season,
                            area: cropSize,
                            imageName: crop.imageName
                        )
                        onSave(newCrop)
                        isShowingCropSchedule = true
                    }) {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 10)
                }
                .background(Color.white)
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showUnitPopup) {
                SelectionPopupView(title: "Select Unit", options: ["Acre", "Hectare", "Square Meter", "Square Feet"], selectedOption: $selectedUnit, isPresented: $showUnitPopup)
            }
            .sheet(isPresented: $showSowingMethodPopup) {
                SelectionPopupView(title: "Select Sowing Method", options: ["Direct Seeding", "Transplanting", "Broadcasting", "Drilling"], selectedOption: $selectedSowingMethod, isPresented: $showSowingMethodPopup)
            }
            .sheet(isPresented: $showPlantingMaterialPopup) {
                SelectionPopupView(title: "Select Planting Material", options: ["Seeds", "Saplings", "Cuttings", "Tissue Culture"], selectedOption: $selectedPlantingMaterial, isPresented: $showPlantingMaterialPopup)
            }
            .sheet(isPresented: $showFarmingTypePopup) {
                SelectionPopupView(title: "Select Farming Type", options: ["Organic", "Conventional", "Hydroponic"], selectedOption: $selectedFarmingType, isPresented: $showFarmingTypePopup)
            }
            .sheet(isPresented: $showIrrigationMethodPopup) {
                SelectionPopupView(title: "Select Irrigation Method", options: ["Drip", "Sprinkler", "Flood", "Manual"], selectedOption: $selectedIrrigationMethod, isPresented: $showIrrigationMethodPopup)
            }
        }


        
    }
    
    // Function to show popups
//    private func showPopup(title: String, options: [String], selection: Binding<String>) {
//        
//        popupTitle = title
//        popupOptions = options
//        popupBinding = selection
//        
//        // Ensuring UI updates happen after state change
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                isPopupPresented = true
//            
//            }
//    }
    




}
//struct FarmingDetailRow: View {
//    let icon: String
//    let title: String
//    let value: String
//
//    var body: some View {
//        HStack {
//            Image(systemName: icon)
//                .foregroundColor(.brown)
//                .frame(width: 24, height: 24)
//            Text(title)
//                .font(.body)
//                .foregroundColor(.black)
//            Spacer()
//            Text(value)
//                .foregroundColor(.gray)
//            Image(systemName: "chevron.right")
//                .foregroundColor(.gray)
//        }
//        .padding()
//        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
//    }
//}
struct FarmingDetailRow: View {
    let icon: String
    let title: String
    let value: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.brown)
                .frame(width: 24, height: 24)
            Text(title)
                .font(.body)
                .foregroundColor(.black)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.3), lineWidth: 1))
    }
}

 //Selection Popup View
struct SelectionPopupView: View {
    let title: String
    let options: [String]
    @Binding var selectedOption: String
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
            VStack(spacing: 20) {
                Text(title)
                    .font(.title2)
                    .bold()
                    .padding(.top, 10)
    
                List(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                        dismiss()
                    }) {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundColor(.black)
                            Spacer()
                            if selectedOption == option {
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

