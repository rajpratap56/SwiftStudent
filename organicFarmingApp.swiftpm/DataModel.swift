//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 14/02/25.
//

struct Crop: Identifiable, Codable {
    var id: Int
    var name: String
    var variety: String
    var date: String
    var season: String
    var area: String
    var imageName: String
}

let crops = [
    Crop(id: 1, name: "SugarCane", variety: " ", date: "", season: "",area: "" , imageName: "sugarcane"),
    Crop(id: 2, name: "Paddy", variety: " ", date: "", season: "",area: "" , imageName: "Paddy"),
    Crop(id: 3, name: "Sunflower", variety: " ", date: "", season: "",area: "" , imageName: "Sunflower"),
    Crop(id: 4, name: "Mustard", variety: " ", date: "", season: "",area: "" , imageName: "Mustard"),
    Crop(id: 5, name: "Corn", variety: " ", date: "", season: "",area: "" , imageName: "corn"),
    Crop(id: 6, name: "Wheat", variety: " ", date: "", season: "",area: "" , imageName: "wheat"),
    Crop(id: 7, name: "Moong", variety: " ", date: "", season: "",area: "" , imageName: "moong"),
    Crop(id: 8, name: "Chilli", variety: "", date: "", season: "", area: "", imageName: "chilli"),
    Crop(id: 9, name: "Okra", variety: "", date: "", season: "", area: "", imageName: "okra"),
    Crop(id: 10, name: "Tomato", variety: "", date: "", season: "", area: "", imageName: "tomato"),
    Crop(id: 11, name: "Brinjal", variety: "", date: "", season: "", area: "", imageName: "brinjal"),
    Crop(id: 12, name: "Potato", variety: " ", date: "", season: "",area: "" , imageName: "potato")
]

let diseaseData: [(name: String, solution: String)] = [
    ("Blight", "Apply copper-based fungicide and remove affected leaves." ),
    ("Powdery Mildew", "Use sulfur spray or neem oil to treat the infection."),
    ("Leaf Spot", "Ensure good air circulation and use organic fungicides."),
    ("Root Rot", "Improve soil drainage and avoid overwatering."),
    ("Rust", "Remove infected leaves and use fungicides like Mancozeb."),
    ("Downy Mildew", "Use Bordeaux mixture and increase plant spacing."),
    ("Anthracnose", "Apply biofungicides and remove infected plant parts.")
]
