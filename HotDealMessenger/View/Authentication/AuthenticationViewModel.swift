//
//  AuthenticationViewModel.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/07.
//

import Foundation
import Combine

enum AuthenticationState {
    case unauthenticated
    case authenticated
}

class AuthenticationViewModel: ObservableObject {
    
    enum Action {
        case googleLogin
    }
    
    @Published var authenticatedState: AuthenticationState = .unauthenticated
    private var container: DIContainer
    private var subscriptions = Set<AnyCancellable>()
    var userId: String?

    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action: Action) {
        switch action {
        case .googleLogin:
            container.services.authService.signInWithGoolge()
                .sink { completion in
                    
                } receiveValue: { [weak self] user in
                    self?.userId = user.id
                }.store(in: &subscriptions)

        }
    }
}
