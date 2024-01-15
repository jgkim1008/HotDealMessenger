//
//  AuthenticationViewModel.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import Foundation

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    @Published var authenticatedState: AuthenticationState = .unauthenticated
    private var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
}
