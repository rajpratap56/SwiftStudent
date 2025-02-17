//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 16/02/25.
//

import Foundation
import SwiftUI

struct SoilView: View {
    let crop: Crop
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20) {
            // Header
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("\(crop.name) - Soil Info")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            
            // Soil Information
            VStack(alignment: .leading, spacing: 12) {
                Text("Recommended Soil Type")
                    .font(.headline)
                Text(getSoilType(for: crop.name))
                    .foregroundColor(.gray)
                
                Text("pH Range")
                    .font(.headline)
                Text(getPHRange(for: crop.name))
                    .foregroundColor(.gray)
                
                Text("Nutrient Requirements")
                    .font(.headline)
                Text(getNutrientInfo(for: crop.name))
                    .foregroundColor(.gray)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarHidden(true)
    }
    
    // Functions to get soil recommendations
    func getSoilType(for crop: String) -> String {
        switch crop.lowercased() {
        case "wheat": return "Loamy, well-drained soil"
        case "rice": return "Clayey soil with good water retention"
        case "corn": return "Sandy loam with good drainage"
        default: return "General fertile soil"
        }
    }
    
    func getPHRange(for crop: String) -> String {
        switch crop.lowercased() {
        case "wheat": return "6.0 - 7.5"
        case "rice": return "5.0 - 6.5"
        case "corn": return "5.8 - 7.0"
        default: return "6.0 - 7.0"
        }
    }
    
    func getNutrientInfo(for crop: String) -> String {
        switch crop.lowercased() {
        case "wheat": return "High nitrogen, moderate phosphorus, potassium"
        case "rice": return "High nitrogen, moderate phosphorus"
        case "corn": return "Balanced NPK (Nitrogen, Phosphorus, Potassium)"
        default: return "Rich in organic matter"
        }
    }
}
