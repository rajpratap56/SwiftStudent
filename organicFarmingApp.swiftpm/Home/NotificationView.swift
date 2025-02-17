//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 16/02/25.
//

import Foundation
import SwiftUI

struct Notification: Identifiable {
    let id = UUID()
    let message: String
    let date: String
}

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    let notifications: [Notification] = [
        Notification(message: "Please complete today's activities for better output", date: "14-02-2025"),
        Notification(message: "Please complete today's activities for better output", date: "13-02-2025"),
        Notification(message: "Please complete today's activities for better output", date: "13-02-2025"),
        Notification(message: "Please complete today's activities for better output", date: "12-02-2025"),
        Notification(message: "Please complete today's activities for better output", date: "12-02-2025")
    ]
    
    var body: some View {
        VStack {
            // Navigation Bar
            HStack {
                Button(action: { presentationMode.wrappedValue.dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundColor(.black)
                }
                
                Spacer()
                Text("Notifications")
                    .font(.title3)
                    .bold()
                Spacer()
            }
            .padding()
            .background(Color.green.opacity(0.3))
            
            // Notification List
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(notifications) { notification in
                        NotificationRow(notification: notification)
                    }
                }
                .padding()
            }
            
            Spacer()
        }
        .background(Color.gray.opacity(0.1))
        .navigationBarHidden(true)
    }
}

// Notification Row UI
struct NotificationRow: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            Image(systemName: "bell.fill")
                .foregroundColor(.green)
                .padding()
            
            VStack(alignment: .leading) {
                Text(notification.message)
                    .font(.body)
                    .foregroundColor(.black)
                Text(notification.date)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            
            Circle()
                .fill(Color.green)
                .frame(width: 10, height: 10)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 1)
    }
}
