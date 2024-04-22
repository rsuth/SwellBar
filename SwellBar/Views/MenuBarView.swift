//
//  MenuBarView.swift
//  SwellBar
//
//  Created by Rick Sutherland on 4/26/24.
//

import SwiftUI

struct MenuBarView: Scene {
    @StateObject var viewModel: MenuBarViewModel
    
    var body: some Scene {
        MenuBarExtra(
            content: {
                VStack {
                    Text("Station: \(viewModel.stationName)")
                    Text("\(viewModel.formattedData[0])\(viewModel.formattedData[1])")
                    Text("From \(viewModel.formattedData[2])")
                    Text("Water Temp: \(viewModel.formattedData[3])")
                    Button("Settings...", action: viewModel.openSettings)
                    Divider()
                    Button("Quit", action: viewModel.quitApplication)
                }
                .padding()
            }, label: {
                Text(viewModel.labelText)
            })
    }
}
