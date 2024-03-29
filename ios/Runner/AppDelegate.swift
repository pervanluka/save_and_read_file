import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        let binaryMessenger = controller.binaryMessenger
        let api = DeviceFileApiImpl()
        DeviceFileApiSetup.setUp(binaryMessenger: binaryMessenger, api: api)

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
