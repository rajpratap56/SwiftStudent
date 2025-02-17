import SwiftUI
import PhotosUI
import UIKit

struct AdvisoryView: View {
    @State private var showCropPicker = false
    @State private var selectedCrop = "Select your crop"
    @State private var sowingDate = "21-02-2025 | Kharif"
    @State private var problemDescription = ""
    @State private var uploadedImages: [UIImage] = []

    @State private var showImagePicker = false
    @State private var showImageSourceActionSheet = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage? = nil
    @State private var showResultScreen = false
    

    let savedCrops = ["Okra *Marvel", "Tomato Hybrid", "Wheat Premium", "Corn Elite"]

    var body: some View {
        VStack {
            // Header
            HStack {
                Spacer()
                Text("Post Query")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            
            // Crop Selection
            VStack(alignment: .leading, spacing: 5) {
                Text("Select your crop")
                    .font(.headline.bold())
                    .foregroundColor(.black)
                
                Button(action: { showCropPicker = true }) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(selectedCrop == "Select your crop" ? "Select your crop" : selectedCrop)
                                .font(.subheadline.bold())
                                .foregroundColor(selectedCrop == "Select your crop" ? .gray.opacity(0.6) : .black)
                            
                            if selectedCrop != "Select your crop" {
                                Text("Sowing Date: \(sowingDate)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white).shadow(radius: 1))
                }
            }
            .padding()
            
            // Problem Description
            VStack(alignment: .leading) {
                Text("Can you describe your problem?")
                    .font(.headline)
                    .foregroundColor(.black)

                ZStack(alignment: .topLeading) {
                    if problemDescription.isEmpty {
                        Text("Describe your problem...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }

                    TextEditor(text: $problemDescription)
                        .frame(minHeight: 80, maxHeight: 120)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white).shadow(radius: 1))
                        .foregroundColor(.black)
                        .opacity(problemDescription.isEmpty ? 0.3 : 1)
                }
            }
            .padding()
            
            // Image Upload Section
            VStack(alignment: .leading, spacing: 5) {
                Text("Upload a Picture")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(uploadedImages.indices, id: \.self) { index in
                            ZStack(alignment: .topTrailing) {
                                Image(uiImage: uploadedImages[index])
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))

                                // Remove Button
                                Button(action: {
                                    uploadedImages.remove(at: index)
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .foregroundColor(.red)
                                        .background(Color.white.clipShape(Circle()))
                                }
                                .offset(x: 5, y: -5)
                            }
                        }

                        Button(action: { showImageSourceActionSheet = true }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1, dash: [5]))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "plus")
                                    .font(.title)
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
                .padding(.top, 5)
            }
            .padding()
            
            // Submit Button
            Button(action: { showResultScreen = true }) {
                Text("Upload & Analyse")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
            }
            .padding(.horizontal, 24)
            .padding(.vertical, 50)
           // .padding()
            .fullScreenCover(isPresented: $showResultScreen) {
                DiseaseResultView(uploadedImages: $uploadedImages)
            }

            Spacer()
        }
        .sheet(isPresented: $showCropPicker) {
            CropSelectionPopup(selectedCrop: $selectedCrop, savedCrops: savedCrops)
                .presentationDetents([.medium])
        }
        .sheet(isPresented: $showImagePicker, onDismiss: {
            if let image = selectedImage {
                uploadedImages.append(image)
            }
        }) {
            ImagePicker(image: $selectedImage, sourceType: sourceType)
        }
        .actionSheet(isPresented: $showImageSourceActionSheet) {
            ActionSheet(
                title: Text("Select Image Source"),
                buttons: [
                    .default(Text("Camera")) {
                        sourceType = .camera
                        showImagePicker = true
                    },
                    .default(Text("Gallery")) {
                        sourceType = .photoLibrary
                        showImagePicker = true
                    },
                    .cancel()
                ]
            )
        }
    }
}
struct CropSelectionPopup: View {
    @Binding var selectedCrop: String
    let savedCrops: [String]
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Select Crop")
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                Spacer()

                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.gray)
                }
                .padding(.trailing)
            }
            .padding()
            .background(Color.green.opacity(0.3))
            .cornerRadius(12)
            
            List(savedCrops, id: \.self) { crop in
                Button(action: {
                    selectedCrop = crop
                    dismiss()
                }) {
                    HStack {
                        Text(crop)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)

                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(selectedCrop == crop ? .green : .clear)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .frame(maxHeight: .infinity)
        .background(Color.white.cornerRadius(16))
        .padding(.horizontal, 10)
    }
}
