import ServiceManagement

class AppUtilities {
    private static var appService: SMAppService?
    
    static func setLaunchAtLogin(enabled: Bool) {
        let service = SMAppService.mainApp
        if enabled {
            do {
                try service.register()
            } catch {
                debugPrint("error registering")
            }
        } else {
            do {
                try service.unregister()
            } catch {
                debugPrint("error unregistering")
            }
        }
    }
}
