//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 12/02/25.
//

import Foundation
import SwiftUI

struct CropScheduleView: View {
    let crop: Crop
    let sowingDate: String
    let closingDate: String
    
    @Environment(\.dismiss) private var dismiss
    @State private var selectedFilter: TaskFilter = .futureTasks
    @State private var navigateToHome = false
    @State private var navigateToCrop = false

    let vegetativeTasks: [Task] = [
        Task(title: "Seed Treatment", startDate: "15/02/2025", endDate: "16/02/2025"),
        Task(title: "Irrigation", startDate: "17/02/2025", endDate: "18/02/2025"),
        Task(title: "Use Of Biofertilizers", startDate: "20/02/2025", endDate: "22/02/2025"),
        Task(title: "Fertigation", startDate: "17/02/2025", endDate: "18/02/2025"),
        Task(title: "Irrigation", startDate: "20/02/2025", endDate: "22/02/2025")
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                //  Custom Navigation Header
                HStack {
                    // Back Button
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                            .foregroundColor(.black)
                            .padding(16)
                           // .background(Color.green) // Green background for the back button
                            .clipShape(Circle())
                    }
                    
                    Spacer(minLength: 8)
                    
                    // Title
                    Text("  \(crop.name) Schedule")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                    Spacer(minLength: 8)
                    
                    // "Done" Button
                    Button(action: { goToHomeScreen() }) {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                    }

                }
                .padding(.horizontal, 8)
                .background(Color.green.opacity(0.3)) // Set green color as the background for the header
                .safeAreaInset(edge: .top) {
                    Color.green.opacity(0.01) // Ensure this part stays within the safe area
                        .frame(height: 45) // Increase this height to push the header more down
                }
                
                ScrollView {
                    VStack(spacing: 0) {
                        // Crop Image
                        Image(crop.imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(height: 200)
                            .clipped()
                            .cornerRadius(12)
                            .padding(.horizontal, 16)
                            .padding(.top, 12)
                        
                        // Dates Section
                        DatesSection(sowingDate: sowingDate, closingDate: closingDate)
                        
                        // Task Filter Tabs
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(TaskFilter.allCases, id: \.self) { filter in
                                    TaskFilterButton(title: filter.rawValue,
                                                     count: filter.taskCount,
                                                     isSelected: selectedFilter == filter)
                                    .onTapGesture {
                                        selectedFilter = filter
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                        }
                        .padding(.vertical, 16)
                        
                        // Vegetative Stage Section
                        StageSection(title: "Vegetative Stage",
                                     description: "Activities - In progress | \(sowingDate) - \(closingDate)",
                                     tasks: vegetativeTasks)
                        .padding(8)
                        .padding(.horizontal, -8)
                        
                        StageSection(title: "Harvesting Stage",
                                     description: "Activities - In progress | \(sowingDate) - \(closingDate)",
                                     tasks: vegetativeTasks)
                    }
                    
                }
                NavigationLink(destination: HomeView(), isActive: $navigateToHome) {
                                    EmptyView()
                                }
            }
            .edgesIgnoringSafeArea(.top) // ✅ Ensures the content fits below the header correctly
        }
    }
}

@MainActor private func goToHomeScreen() {
    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
       let window = windowScene.windows.first {
        window.rootViewController = UIHostingController(rootView: ContentView()) // Replace with your TabView
        window.makeKeyAndVisible()
    }
}






// MARK: - Reusable Components

struct DatesSection: View {
    let sowingDate: String
    let closingDate: String

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Sowing date:")
                    .foregroundColor(.green)
                    .bold()
                Text(sowingDate)
                    .font(.headline)
                    .foregroundColor(.black)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Closing date:")
                    .foregroundColor(.green)
                    .bold()
                Text(closingDate)
                    .font(.headline)
                    .foregroundColor(.black)
            }
        }
        .padding(.horizontal, 24)
        .padding(.top, 8)
    }
}

struct TaskFilterButton: View {
    let title: String
    let count: Int
    let isSelected: Bool

    var body: some View {
        Text("\(title) (\(count))")
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.green.opacity(0.2) : Color.white)
            .foregroundColor(isSelected ? .green : .black)
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.green, lineWidth: isSelected ? 2 : 1))
            .animation(.easeInOut, value: isSelected)
    }
}

struct StageSection: View {
    let title: String
    let description: String
    let tasks: [Task] // Tasks for this stage

    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Button(action: { withAnimation { isExpanded.toggle() } }) {
                HStack {
                    Text(title)
                        .font(.headline)
                        .bold()
                        .foregroundColor(.black)
                    Spacer()
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 16)
            }

            Text(description)
                .foregroundColor(.gray)
                .padding(.horizontal, 16)

            if isExpanded {
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(tasks) { task in
                            TaskItemView(task: task)
                        }
                    }
                    .padding(.top, 8)
                }
                .frame(height: 200) // Set height for scrollable area
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
        .padding(.horizontal, 16)
    }
}

struct TaskListView: View {
    let tasks: [Task]

    var body: some View {
        VStack(spacing: 12) {
            ForEach(tasks) { task in
                TaskItemView(task: task)
            }
        }
        .padding(.top, 8)
    }
}

struct TaskItemView: View {
    let task: Task
    @State private var showWeedManagementView = false  // ✅ State for navigation

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(task.title.uppercased())
                    .font(.headline)
                    .bold()
                    .foregroundColor(.black)
                Spacer()
                Button(action: { showWeedManagementView = true }) {  // ✅ Click to open new view
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                }
                .fullScreenCover(isPresented: $showWeedManagementView) {  // ✅ Show WeedManagementView
                    WeedManagementView()
                }
            }

            Text("\(task.startDate) - \(task.endDate)")
                .font(.subheadline)
                .foregroundColor(.gray)

            HStack {
                Button(action: { /* Handle Mark as Complete */ }) {
                    Text("Mark as complete")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.green)
                        .clipShape(Capsule())
                }

                Spacer()

                Button(action: { /* Handle Skip */ }) {
                    Text("Skip")
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).stroke(Color.black.opacity(0.2)))
        .padding(.horizontal, 16)
    }
}


struct Task: Identifiable {
    let id = UUID()
    let title: String
    let startDate: String
    let endDate: String
}


// MARK: - Enums for Better Data Management

enum TaskFilter: String, CaseIterable {
    case futureTasks = "Future Task"
    case today = "Today"
    case pending = "Pending"
    case completed = "Completed"
    case skipped = "Skip"
    case total = "Total"

    var taskCount: Int {
        switch self {
        case .futureTasks: return 62
        case .today: return 2
        case .pending: return 9
        case .completed: return 5
        case .skipped: return 3
        case .total: return 5
        }
    }
}
