import SwiftUI

struct HomeView: View {
    @State private var searchText = ""
    @State private var selectedCrop: Crop?
    @State private var showProfile = false // State to toggle ProfileView
    @State private var showNotifications = false
    
    var filteredCrops: [Crop] {
        searchText.isEmpty ? crops : crops.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                // Profile Section
                HStack {
                    Button(action: {
                        showProfile = true // Open ProfileView
                    }) {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.green)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Hi Raj")
                            .font(.title2)
                            .bold()
                        Text("Beta 2 Greater Noida")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    Button(action: { showNotifications = true }) {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.gray)
                    }}
                .padding(.horizontal, 16)
                
                // Weather Section
                HStack {
                    VStack(alignment: .leading) {
                        Text("🌤 Greater Noida")
                            .font(.headline)
                        Text("30° C | Clear")
                            .font(.subheadline)
                            .bold()
                        Text("Rain: 0mm | Wind: 2.9m/s | Rain Prediction: 50%")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "cloud.sun.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.yellow)
                }
                .padding()
                .background(Color.green.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal, 16)
                
                // Search Bar
                TextField("Search Crop Name", text: $searchText)
                    .padding(12)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal, 16)
                
                // Crop Grid
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
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
                    .padding(.horizontal, 16)
                    .padding(.top, 6)
                }
                .padding(.bottom, 12)
            }
            .sheet(item: $selectedCrop) { crop in
                CropDetailView(crop: crop)
            }
            .sheet(isPresented: $showProfile) {
                ProfileView() // Present ProfileView when profile button is tapped
            }
            .sheet(isPresented: $showNotifications) {
                            NotificationView()
                        }
            
        }
    }
}
