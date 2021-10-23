//
//  Photo_Editor_AppApp.swift
//  Photo Editor App
//
//  Created by macbook on 2021/10/12.
//

import SwiftUI

@main
struct Photo_Editor_AppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(ImageController())
        }
    }
}
