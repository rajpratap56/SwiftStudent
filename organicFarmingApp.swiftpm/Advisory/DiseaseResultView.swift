import SwiftUI

struct DiseaseResultView: View {
    @Binding var uploadedImages: [UIImage] // Accept multiple images

    @Environment(\.dismiss) var dismiss

    let columns = [GridItem(.adaptive(minimum: 120))] // Grid layout


    var detectedDisease: (name: String, solution: String)? {
        uploadedImages.isEmpty ? nil : diseaseData.randomElement()
    }

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Analysis Result")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))

            if uploadedImages.isEmpty {
                // No images uploaded, show message instead
                VStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
                        .foregroundColor(.orange)
                        .padding()

                    Text("No image uploaded")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.red)
                        .padding(.bottom, 5)

                    Text("Please upload an image to get disease analysis.")
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }
                .padding()
            } else {
                // Display images in a horizontal scroll view
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 5) {
                        ForEach(uploadedImages, id: \.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 366, height: 250)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                        }
                    }
                    .padding()
                }

                // Disease Info
                Text("Detected Disease:")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 10)

                if let disease = detectedDisease {
                    Text(disease.name)
                        .font(.title)
                        .bold()
                        .foregroundColor(.red)

                    // Solution
                    Text("Solution:")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding(.top, 5)

                    Text("❗ **\(disease.solution)**")
                        .foregroundColor(.green)
                        .font(.body)
                        .padding(.horizontal)
                }
            }

            Spacer()

            // Analyze Again Button
            Button(action: {
                uploadedImages = []
                dismiss() }) {
                Text("Analyze Again")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
            }
            .padding()
        }
        .background(Color.white.ignoresSafeArea())
    }
}
