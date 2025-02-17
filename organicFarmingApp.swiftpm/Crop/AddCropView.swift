import SwiftUI

struct AddCropView: View {
    var onSave: (Crop) -> Void
    @State private var searchText = ""
    @State private var selectedCrop: Crop?
    
    var filteredCrops: [Crop] {
        searchText.isEmpty ? crops : crops.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }

    var body: some View {
        VStack {
            // Search Bar
            Spacer()
            TextField("Search Crop Name", text: $searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            // Crop Grid View
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                    ForEach(filteredCrops) { crop in
                        VStack {
                            Image(crop.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 160, height: 130)
                                .clipped()
                                .cornerRadius(10)
                            
                            Text(crop.name)
                                .font(.headline)
                        }
                        .padding(8)
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(12)
                        .shadow(radius: 2)
                        .onTapGesture {
                            selectedCrop = crop
                        }
                    }
                }
                .padding()
            }
        }
        .sheet(item: $selectedCrop) { crop in
            CropDetailView(crop: crop)
        }
        
        .navigationTitle("Add Crop")
        .navigationBarTitleDisplayMode(.inline)
    }
}
