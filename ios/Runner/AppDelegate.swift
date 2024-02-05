import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let binaryMessenger = window?.rootViewController as! FlutterBinaryMessenger
        let api = DeviceFileApi()
        DeviceFileApi.setup(binaryMessenger, api)
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
