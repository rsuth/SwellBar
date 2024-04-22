import SwiftUI

class UserPreferences: ObservableObject {
    @Published var showWaveHeight: Bool {
        didSet { UserDefaults.standard.set(showWaveHeight, forKey: "showWaveHeight") }
    }
    @Published var showWavePeriod: Bool {
        didSet { UserDefaults.standard.set(showWavePeriod, forKey: "showWavePeriod") }
    }
    @Published var showWaveDirection: Bool {
        didSet { UserDefaults.standard.set(showWaveDirection, forKey: "showWaveDirection") }
    }
    @Published var showWaterTemp: Bool {
        didSet { UserDefaults.standard.set(showWaterTemp, forKey: "showWaterTemp") }
    }
    @Published var useMetric: Bool {
        didSet { UserDefaults.standard.set(useMetric, forKey: "useMetric") }
    }
    @Published var showCompassDegrees: Bool {
        didSet { UserDefaults.standard.set(showCompassDegrees, forKey: "showCompassDegrees") }
    }
    @Published var launchOnStartup: Bool {
        didSet { UserDefaults.standard.set(launchOnStartup, forKey: "launchOnStartup") }
    }
    @Published var stationID: String {
        didSet { UserDefaults.standard.set(stationID, forKey: "stationID") }
    }

    init() {
        let defaults = [
            "showWaveHeight": true,
            "showWavePeriod": true,
            "showWaveDirection": true,
            "showWaterTemp": true,
            "useMetric": false,
            "showCompassDegrees": false,
            "launchOnStartup": false,
            "stationID": "46225"
        ] as [String : Any]
        
        UserDefaults.standard.register(defaults: defaults)

        self.showWaveHeight = UserDefaults.standard.bool(forKey: "showWaveHeight")
        self.showWavePeriod = UserDefaults.standard.bool(forKey: "showWavePeriod")
        self.showWaveDirection = UserDefaults.standard.bool(forKey: "showWaveDirection")
        self.showWaterTemp = UserDefaults.standard.bool(forKey: "showWaterTemp")
        self.useMetric = UserDefaults.standard.bool(forKey: "useMetric")
        self.showCompassDegrees = UserDefaults.standard.bool(forKey: "showCompassDegrees")
        self.launchOnStartup = UserDefaults.standard.bool(forKey: "launchOnStartup")
        self.stationID = UserDefaults.standard.string(forKey: "stationID") ?? "46225"
    }
}


