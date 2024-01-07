//
//  HotDealMessengerApp.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import SwiftUI

@main
struct HotDealMessengerApp: App {
    @StateObject var container: DIContainer = .init(services: Services())
    
    var body: some Scene {
        WindowGroup {
            AuthenticatedView(authViewModel: .init())
                .environmentObject(container)
        }
    }
}
