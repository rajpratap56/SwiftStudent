import SwiftUI

struct CropView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var crops: [Crop] = [] // Store crops data
    @State private var showCropDetailView = false // Toggle for adding a new crop


    var body: some View {
        NavigationStack {
            VStack {
                // Header
                HStack {
                    Spacer()
                    Text("Crops (\(crops.count))")
                        .font(.title3)
                        .bold()
                    Spacer()
                }
                .padding()
                .background(Color.green.opacity(0.3))

                // Crop List
                ScrollView {
                    VStack(spacing: 16) {
                        if crops.isEmpty {
                            Text("No crops added yet")
                                .foregroundColor(.gray)
                                .padding(.top, 50)
                        } else {
                            ForEach(crops) { crop in
                                CropCardView(crop: crop, onDelete: { deleteCrop(crop) })
                            }
                        }
                    }
                }

                Spacer()

                // Add Crop Button
                Button(action: {
                    showCropDetailView = true
                }) {
                    Text("Add Crop")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(12)
                    
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 10)
                
                .sheet(isPresented: $showCropDetailView) {
                    AddCropView { newCrop in
                        crops.append(newCrop)
                        saveCrops()
                    }
                }
            }
            .navigationBarHidden(true)
            .onAppear {
                loadCrops()
            }
        }
    }

    // Load Crops from UserDefaults
    private func loadCrops() {
        if let savedCrops = UserDefaults.standard.data(forKey: "crops"),
           let decodedCrops = try? JSONDecoder().decode([Crop].self, from: savedCrops) {
            self.crops = decodedCrops
        }
    }

    // Save Crops to UserDefaults
    private func saveCrops() {
        if let encodedData = try? JSONEncoder().encode(crops) {
            UserDefaults.standard.set(encodedData, forKey: "crops")
        }
    }

    // Delete Crop Functionality
    private func deleteCrop(_ crop: Crop) {
        crops.removeAll { $0.id == crop.id }
        saveCrops()
    }
}

// MARK: - CropCardView Component

struct CropCardView: View {
    let crop: Crop
    let onDelete: () -> Void
    @State private var showCropSchedule = false  // State to trigger modal
    @State private var showExpenseView = false
    @State private var showSoilView = false
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image(crop.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    Button(action: { onDelete() }) {
                        Label("Delete", systemImage: "trash")
                            .padding(8)
                            .background(Color.red.opacity(0.8))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    Text("\(crop.area) Acre")
                        .padding(8)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding()
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(crop.name)
                    .font(.headline)
                    .bold()
                Text(crop.variety)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Text("\(crop.date) - \(crop.season)")
                    .font(.subheadline)
            }
            .padding(.horizontal)

            HStack(spacing: 12) {
                // ✅ Schedule Button with Full-Screen Presentation
                Button(action: {
                    showCropSchedule = true
                }) {
                    CropFeatureButton(title: "Schedule", systemImage: "calendar")
                }
                .fullScreenCover(isPresented: $showCropSchedule) {
                    CropScheduleView(crop: crop, sowingDate: "15/02/2025", closingDate: "30/05/2025")
                }

                Button(action: {
                    showExpenseView = true
                }) {
                    CropFeatureButton(title: "Expenses", systemImage: "doc.text")
                }
                .fullScreenCover(isPresented: $showExpenseView) {
                    ExpenseView(crop: crop)
                }
                Button(action: {
                                   showSoilView = true  // Action for Soil button
                               }) {
                                   CropFeatureButton(title: "Soil", systemImage: "leaf.fill")
                               }
                               .fullScreenCover(isPresented: $showSoilView) {
                                   SoilView(crop: crop) // Opens the SoilView screen
                               }
            }
            .frame(maxWidth: .infinity, maxHeight: 35)
            .padding()
        }
        .background(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))
        .padding(.horizontal)
    }
}

struct CropFeatureButton: View {
    let title: String
    let systemImage: String
    
    var body: some View {
        VStack {
            Image(systemName: systemImage)
                .font(.title2)
                .foregroundColor(.brown)
            Text(title)
                .font(.footnote)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, minHeight: 35)
        .padding()
        .background(Color.yellow.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
