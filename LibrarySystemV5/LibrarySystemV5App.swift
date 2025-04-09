//
//  LibrarySystemV5App.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 16/03/2025.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    if FirebaseApp.app() != nil {
              print("✅ Firebase initialized successfully")
          } else {
              print("❌ Firebase failed to initialize")
          }

    return true
  }
}


@main
struct LibrarySystemV5App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            SplashScreen()
        }
    }
}
