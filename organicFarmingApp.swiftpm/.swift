//
//  File.swift
//  organicFarmingApp
//
//  Created by RajPratapSingh on 12/02/25.
//

import SwiftUI
import CalendarKit

struct CalendarViewWrapper: UIViewControllerRepresentable {
    @Binding var selectedDate: String?
    @Binding var showDatePicker: Bool

    func makeUIViewController(context: Context) -> CalendarViewController {
        let calendarVC = CalendarViewController()
        calendarVC.delegate = context.coordinator
        return calendarVC
    }

    func updateUIViewController(_ uiViewController: CalendarViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, CalendarViewControllerDelegate {
        let parent: CalendarViewWrapper

        init(_ parent: CalendarViewWrapper) {
            self.parent = parent
        }

        func calendarViewController(_ controller: CalendarViewController, didSelectDate date: Date) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy"
            parent.selectedDate = dateFormatter.string(from: date)
            parent.showDatePicker = false
        }
    }
}

