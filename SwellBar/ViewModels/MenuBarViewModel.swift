import Combine
import SwiftUI

class MenuBarViewModel: ObservableObject {
    @Published var swellData: SwellData? = nil
    @Published var stationList: [SwellStation]? = nil
    @Published var userPreferences: UserPreferences = UserPreferences()
    @Published var labelText: String = "🌊..."
    @Published var formattedData: [String] = ["--","--","--","--"]
    @Published var stationName: String = ""
    
    
    private var timer: AnyCancellable?
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchStationList()
        setupObservers()
        setupTimer()
    }
    
    private func buildLabelText() -> String {        
        var labelComponents: [String] = []
        
        if userPreferences.showWaveHeight {
            labelComponents.append(formattedData[0])
        }
        
        if userPreferences.showWavePeriod {
            labelComponents.append(formattedData[1])
        }
        
        if userPreferences.showWaveDirection {
            labelComponents.append(formattedData[2])
        }
        
        if userPreferences.showWaterTemp {
            labelComponents.append(formattedData[3])
        }
        
        if labelComponents.isEmpty {
            // minimal view
            return "🌊"
        }
        
        return labelComponents.joined(separator: " ")
        
    }
    
    private func updateText() {
        self.formattedData = getFormattedDataStringComponents()
        self.labelText = buildLabelText()
    }
    
    private func getFormattedDataStringComponents() -> [String] {
        guard let swellData = swellData else {
            return ["--","--","--","--"]
        }
        
        var components: [String] = []
        
        // Height
        if let h = swellData.waveHeight {
            if userPreferences.useMetric{
                components.append("\(h)m")
            } else {
                components.append("\(DataFormatter.metersToFeet(meters: h))ft")
            }
        } else {
            if userPreferences.useMetric{
                components.append("--m")
            } else {
                components.append("--ft")
            }
        }
        
        // Period
        if let p = swellData.wavePeriod {
            components.append("@ \(p)s")
        } else {
            components.append("@ --s")
        }
        
        // Direction
        if let dir = swellData.waveDirection {
            if userPreferences.showCompassDegrees {
                components.append("\(DataFormatter.directionToEmoji(fromDegrees: dir)) \(dir)°")
            } else {
                components.append("\(DataFormatter.directionToEmoji(fromDegrees: dir)) \(DataFormatter.compassDirection(fromDegrees: dir))")
            }
        } else {
            components.append("⬆️ --")
        }
        
        // Temp
        if let t = swellData.waterTemp {
            if userPreferences.useMetric {
                components.append("💧 \(t)°")
            } else {
                components.append("💧 \(DataFormatter.celsiusToFahrenheit(celsius: t))°")
            }
        } else {
            components.append("💧 --")
        }
        return components
    }

    private func setupObservers() {
        // Observing changes to stationID
        userPreferences.$stationID
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.fetchData()
                    guard let list = self?.stationList else {
                        self?.stationName = " "
                        return
                    }
                    self?.stationName = self?.getStationName(list: list) ?? " "
                }
            }
            .store(in: &cancellables) 

        // Merge changes from all settings impacting the labelText
        let settingsChanges = Publishers.MergeMany(
            userPreferences.$showWaveHeight.map { _ in },
            userPreferences.$showWavePeriod.map { _ in },
            userPreferences.$showWaveDirection.map { _ in },
            userPreferences.$showWaterTemp.map { _ in },
            userPreferences.$useMetric.map { _ in },
            userPreferences.$showCompassDegrees.map { _ in }
        )

        settingsChanges
            .sink { [weak self] _ in
                DispatchQueue.main.async {
                    self?.updateText()
                }
            }
            .store(in: &cancellables)
    }

    private func setupTimer() {
        fetchData()  // Fetch initial data
        fetchStationList() // Fetch list

        timer = Timer.publish(every: 600, on: .main, in: .common).autoconnect()
            .sink { [weak self] _ in
                self?.fetchData()
            }
        timer?.store(in: &cancellables)
    }
    
    func fetchData() {
        DataService.shared.fetchStationData(stationId: userPreferences.stationID){ [weak self] data in
            DispatchQueue.main.async {
                guard let data = data else {
                    print("error")
                    return
                }
                self?.swellData = data
                self?.updateText()
            }
        }
    }
    
    func fetchStationList() {
        DataService.shared.fetchStationList { [weak self] list, _error in
                DispatchQueue.main.async {
                    guard let self = self, let list = list else {
                        print("Error loading stations")
                        return
                    }
                    self.stationList = list
                    self.stationName = self.getStationName(list: list)
                }
            }
    }
    
    func getStationName(list:[SwellStation]) -> String {
        if let station = list.first(where: { $0.id == self.userPreferences.stationID }) {
           return station.name
        } else {
            return " " // Fallback in case no matching station is found
        }
    }
    
    public func quitApplication() {
        NSApplication.shared.terminate(nil)
    }
    
    public func openSettings() {
        debugPrint("Opening settings window")
        WindowManager.shared.openSettingsWindow(preferences: userPreferences)
    }
    
    deinit {
        timer?.cancel()
    }
}
