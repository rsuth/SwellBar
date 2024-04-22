import SwiftUI

struct SettingsView: View {
    @ObservedObject var preferences: UserPreferences
    @ObservedObject var stationListViewModel = StationListViewModel()
    
    var body: some View {
        Form {
            Picker("Select Station:", selection: $preferences.stationID) {
                            ForEach(stationListViewModel.stations, id: \.id) { station in
                                Text("\(station.id) - \(station.name)").tag(station.id)
                            }
                        }
                        .onAppear(perform: stationListViewModel.fetchStations).padding(.bottom)

            // Handle loading and errors
            if stationListViewModel.isLoading {
                Text("Loading stations...")
            }
            if let errorMessage = stationListViewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }

            Section(header: Text("Display Options").font(.subheadline)) {
                Toggle("Show Swell Height", isOn: $preferences.showWaveHeight)
                Toggle("Show Swell Period", isOn: $preferences.showWavePeriod)
                Toggle("Show Swell Direction", isOn: $preferences.showWaveDirection)
                Toggle("Show Water Temp", isOn: $preferences.showWaterTemp).padding(.bottom)
            }
            Section(header: Text("General Settings").font(.subheadline)) {
                Toggle("Use Metric Units", isOn: $preferences.useMetric)
                Toggle("Show Compass Degrees", isOn: $preferences.showCompassDegrees).padding(.bottom)
            }
            Section(header: Text("Application").font(.subheadline)) {
                Toggle("Launch on Startup", isOn: $preferences.launchOnStartup)
                    .onChange(of: preferences.launchOnStartup) {
                        AppUtilities.setLaunchAtLogin(enabled: preferences.launchOnStartup)
                    }.padding(.bottom)
            }
        }
        .padding()
        .frame(width: 350)
    }
}


//struct SettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingsView(preferences: UserPreferences())
//    }
//}


