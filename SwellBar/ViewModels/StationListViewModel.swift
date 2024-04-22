//
//  StationListViewModel.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/23/24.
//

import Foundation

class StationListViewModel: ObservableObject {
    @Published var stations: [SwellStation] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchStations() {
        isLoading = true
        DataService.shared.fetchStationList { [weak self] result, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if let stations = result {
                    self?.stations = stations.sorted(by: {
                        $0.name < $1.name
                    })
                } else if let error = error {
                    self?.errorMessage = "Failed to load stations: \(error.localizedDescription)"
                }
            }
        }
    }
}

