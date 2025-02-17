import SwiftUI

struct WeedManagementView: View {
    @Environment(\.dismiss) private var dismiss  // Allows back navigation

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Custom Navigation Header
                HStack {
                    // Back Button
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // Title
                    Text("Activity Details")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    // Spacer to balance layout
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.clear) // Hidden for spacing
                            .padding()
                    }
                }
                .padding(.horizontal)
                .background(Color.green.opacity(0.3)) // Light background
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        // Top Image
                        Spacer()
                        Image("seed") // Add your actual image in Assets
                            .resizable()
                            .scaledToFill()
                            .frame(height: 230)
                            .frame(width: 365)
                            .clipped()
                            .cornerRadius(10)
                            .padding(.horizontal)
                        
                        // Activity Title & Info
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Activity: Biological Seed Treatment")
                                .font(.title3)
                                .bold()
                        }
                        .padding(.horizontal)

                        // Sections
                        SectionView(title: "Description", content: "Apply pre-emergence herbicide to control early weed growth in okra fields.")

                        SectionView(title: "Specification", content: """
                        1. Use Pendimethalin 30% EC at 1.0 kg a.i./ha as pre-emergence application.
                        2. Ensure uniform soil moisture before application for better effectiveness.
                        3. Use post-emergence weeding at 20-25 days for effective weed control.
                        """)

                        SectionView(title: "Advantages", content: """
                        1. Reduces weed competition with crops.
                        2. Enhances nutrient uptake by okra plants.
                        3. Increases yield and quality of the produce.
                        """)

                        SectionView(title: "Care to be taken", content: """
                        1. Avoid herbicide drift to non-target plants.
                        2. Apply when wind speed is low to prevent spread.
                        3. Use proper protective equipment while spraying.
                        """)

                        Spacer()
                    }
                }
            }
        }
    }
}

// Reusable Section View
struct SectionView: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundColor(.green)

            Text(content)
                .font(.body)
                .foregroundColor(.black)

            Divider()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}
