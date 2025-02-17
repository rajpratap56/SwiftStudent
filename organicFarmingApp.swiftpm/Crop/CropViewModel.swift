//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 12/02/25.
//

import SwiftUI

class CropViewModel: ObservableObject {
    @Published var savedCrops: [Crop] = []

    init() {
        loadCrops() // Load saved crops when the app starts
    }

    func addCrop(_ crop: Crop) {
        savedCrops.append(crop)
        saveCrops()
    }

    private func saveCrops() {
        if let encodedData = try? JSONEncoder().encode(savedCrops) {
            UserDefaults.standard.set(encodedData, forKey: "crops")
        }
    }

    private func loadCrops() {
        if let data = UserDefaults.standard.data(forKey: "crops"),
           let decodedCrops = try? JSONDecoder().decode([Crop].self, from: data) {
            savedCrops = decodedCrops
        }
    }
}
