//
//  AuthenticatedView.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import SwiftUI

struct AuthenticatedView: View {
    @StateObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        switch authViewModel.authenticatedState {
        case .unauthenticated:
            //TODO: loginView
            LoginIntroView()
        case .authenticated:
            MainTabView()
            //TODO: mainView
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticatedView(authViewModel: .init(container: .init(services: StubService())))
    }
}
