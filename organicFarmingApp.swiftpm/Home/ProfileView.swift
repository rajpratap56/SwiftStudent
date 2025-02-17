import SwiftUI
import PhotosUI

struct ProfileView: View {
    @State private var profileImage: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var showActionSheet = false
    @State private var showLanguagePopup = false
    @State private var selectedLanguage = "English"
    @State private var showAccountDetails = false
    @Environment(\.dismiss) var dismiss
    @State private var showAboutUs = false
    @State private var showContactUs = false
    @State private var showFAQ = false

    var body: some View {
        VStack {
            // Close Button
            HStack {
                Spacer()
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
            }
            
            // Profile Image Section
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .overlay(
                        Group {
                            if let profileImage = profileImage {
                                Image(uiImage: profileImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.white)
                            }
                        }
                    )
                
                // Camera Button
                VStack {
                    Spacer().frame(height: 110)
                    Button(action: { showActionSheet = true }) {
                        Image(systemName: "camera.fill")
                            .font(.title2)
                            .padding(8)
                            .background(Color.green.opacity(0.8))
                            .clipShape(Circle())
                            .foregroundColor(.white)
                    }
                    .actionSheet(isPresented: $showActionSheet) {
                        ActionSheet(
                            title: Text("Select Image Source"),
                            buttons: [
                                .default(Text("Camera")) {
                                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                                        sourceType = .camera
                                        isImagePickerPresented = true
                                    } else {
                                        print("Camera not available")
                                    }
                                },
                                .default(Text("Photo Library")) {
                                    sourceType = .photoLibrary
                                    isImagePickerPresented = true
                                },
                                .cancel()
                            ]
                        )
                    }
                }
            }
            .padding(.bottom, 5)

            // User Details
            Text("Raj Pratap Singh")
                .font(.title2)
                .bold()
            Text("9473173279")
                .font(.subheadline)
                .foregroundColor(.gray)

            // Profile Options List
            List {
                Section {
                    Button(action: { showLanguagePopup = true }) {
                        ProfileRow(icon: "globe", title: "Language", value: selectedLanguage)
                    }
                    Button(action: { showAccountDetails = true }) {
                        ProfileRow(icon: "shield.fill", title: "Account Details")
                    }
                    Button(action: { showFAQ = true }) {
                                            ProfileRow(icon: "questionmark.circle", title: "FAQ")
                                        }
                    Button(action: { showAboutUs = true }) {
                                           ProfileRow(icon: "info.circle", title: "About Us")
                                       }
                    Button(action: { showContactUs = true }) {
                                            ProfileRow(icon: "phone.fill", title: "Contact Us")
                                        }
                }
            }
            .listStyle(.insetGrouped)

            // Logout Button
            Button(action: { print("Logout tapped") }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.green, lineWidth: 2)
                    )
            }
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $profileImage, sourceType: sourceType)
        }
        .sheet(isPresented: $showLanguagePopup) {
            LanguageSelectionView(selectedLanguage: $selectedLanguage)
                .presentationDetents([.medium]) // Half-screen popup
        }
        .sheet(isPresented: $showAccountDetails) {
            AccountDetailsView()
               // .presentationDetents([.medium]) // Half-screen popup
        }
        .sheet(isPresented: $showAboutUs) {
                    AboutUsView()
                    //    .presentationDetents([.medium]) // Half-screen popup
                }
        .sheet(isPresented: $showContactUs) {
                    ContactUsView()
                      //  .presentationDetents([.medium]) // Half-screen popup
                }
        .sheet(isPresented: $showFAQ) {
                   FAQView()
                     //  .presentationDetents([.medium]) // Half-screen popup
               }
    }
}

struct AboutUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("About Us")
                    .font(.title2)
                    .bold()
                Spacer()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))

            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("We're a group of farmers, trainers, researchers and technologists to transform sustainable & organic farming across India and the world.")
                    
                    Text("Our vision is to make Organic Farming mainstream through a transformational end-to-end solution consisting of breakthrough research, training & education, innovative agri-input products, and associated services delivered through cutting-edge technology.")
                    
                    Text("Our mission is to double the income of 1,00,000 farmers & bring 10,00,000 acres under organic farming techniques by 2025 (or earlier).")
                    
                    Link("Terms and Conditions", destination: URL(string: "https://example.com")!)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
            Spacer()
        }
    }
}

struct ContactUsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Contact Us")
                    .font(.title2)
                    .bold()
                Spacer()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))

            VStack(alignment: .leading, spacing: 12) {
                Text("📍 Address:")
                    .font(.headline)
                    .padding(.horizontal, -40)
                Text("Organic Farming Solutions Pvt Ltd,\nNew Delhi, India")

                Text("📞 Phone:")
                    .font(.headline)
                    .padding(.horizontal, -40)
                Link("Call: +91 9473173569", destination: URL(string: "tel:+919473173279")!)
                    .foregroundColor(.blue)

                Text("📧 Email:")
                    .font(.headline)
                    .padding(.horizontal, -40)
                Link("Email: support@organicfarm.com", destination: URL(string: "mailto:support@organicfarm.com")!)
                    .foregroundColor(.blue)

                Spacer()
            }
            .padding()
        }
    }
}


// Profile Row Component
struct ProfileRow: View {
    var icon: String
    var title: String
    var value: String? = nil

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.green)
                .frame(width: 30)
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            if let value = value {
                Text(value)
                    .foregroundColor(.gray)
            }
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
    }
}

struct FAQView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing:8) {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer(minLength: 50)
                Text("FAQ")
                    .font(.title2)
                    .bold()
                Spacer(minLength: 40)
              //  Spacer(minLength: 80)
            }
            .padding()
            .background(Color.green.opacity(0.3))
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    FAQItem(question: "What is organic farming?", answer: "Organic farming is a method that relies on natural inputs like compost, crop rotation, and biological pest control instead of synthetic chemicals.")
                    
                    FAQItem(question: "How can I switch to organic farming?", answer: "You can start by reducing chemical inputs, improving soil health, and using organic-certified seeds and fertilizers.")
                    
                    FAQItem(question: "Is organic farming profitable?", answer: "Yes, organic farming can be profitable due to premium prices for organic produce and reduced input costs.")
                    
                    FAQItem(question: "How do I get organic certification?", answer: "You need to follow organic farming guidelines for a transition period and apply for certification from an authorized body.")
                }
                .padding()
            }
        }
    }
}

struct FAQItem: View {
    var question: String
    var answer: String
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                withAnimation { isExpanded.toggle() }
            }) {
                HStack {
                    Text(question)
                        .font(.headline)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)

            }
            if isExpanded {
                Text(answer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 5)
            }
            Divider()
        }
    }
}

// Language Selection View
struct LanguageSelectionView: View {
    @Binding var selectedLanguage: String
    @Environment(\.dismiss) var dismiss

    let languages = ["English", "Hindi", "Marathi", "Gujarati", "Tamil", "Telugu"]

    var body: some View {
        NavigationView {
            List {
                ForEach(languages, id: \.self) { language in
                    Button(action: {
                        selectedLanguage = language
                        dismiss()
                    }) {
                        HStack {
                            Text(language)
                                .foregroundColor(.primary)
                            Spacer()
                            if language == selectedLanguage {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Select Language")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}

// Account Details View
struct AccountDetailsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title)
                        .foregroundColor(.black)
                }
                Spacer()
                Text("Account Details")
                    .font(.title2)
                    .bold()
                Spacer()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("Name:").bold()
                    Spacer()
                    Text("Raj Pratap Singh")
                }
                
                HStack {
                    Text("Mobile:").bold()
                    Spacer()
                    Text("9473173279")
                }
                
                HStack {
                    Text("Email:").bold()
                    Spacer()
                    Text("raj@example.com")
                }
                
                HStack {
                    Text("Address:").bold()
                    Spacer()
                    Text("New Delhi, India")
                }
            }
            .padding()
            
            Spacer()

        }
    }
}

// Image Picker View
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true)
        }
    }
}
