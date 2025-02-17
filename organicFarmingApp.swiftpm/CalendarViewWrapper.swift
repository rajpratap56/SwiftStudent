//
//  CalendarViewWrapper.swift
//  OrganicFarming
//
//  Created by RajPratapSingh on 11/02/25.
//

import SwiftUI
import UIKit

struct CalendarViewWrapper: UIViewControllerRepresentable {
    @Binding var selectedDate: String?
    @Binding var showDatePicker: Bool

    func makeUIViewController(context: Context) -> UIViewController {
        let calendarViewController = UIViewController()
        let calendarView = UICalendarView()
        
      
        let selection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        calendarView.selectionBehavior = selection
        
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        calendarViewController.view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: calendarViewController.view.topAnchor),
            calendarView.leadingAnchor.constraint(equalTo: calendarViewController.view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: calendarViewController.view.trailingAnchor),
            calendarView.bottomAnchor.constraint(equalTo: calendarViewController.view.bottomAnchor)
        ])
        
        return calendarViewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, @preconcurrency UICalendarSelectionSingleDateDelegate {
        var parent: CalendarViewWrapper

        init(_ parent: CalendarViewWrapper) {
            self.parent = parent
        }

        @MainActor func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
            guard let dateComponents = dateComponents,
                  let date = Calendar.current.date(from: dateComponents) else { return }
            
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            self.parent.selectedDate = formatter.string(from: date)
            parent.showDatePicker = false
        }
    }
}
