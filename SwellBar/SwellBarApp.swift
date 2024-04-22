import SwiftUI

@main
struct SwellBarApp: App {
    @StateObject var viewModel: MenuBarViewModel = MenuBarViewModel()

    var body: some Scene {
        MenuBarView(viewModel: viewModel)
    }
}
