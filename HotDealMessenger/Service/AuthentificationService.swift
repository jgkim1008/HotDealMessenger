//
//  AuthentificationService.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/15.
//

import Foundation
import Combine
import FirebaseCore
import FirebaseAuth
import GoogleSignIn

enum AuthenticationError: Error {
    case clientIDError
    case tokenError
    case invalidated
}

protocol AuthentificationServiceType {
    func signInWithGoolge() -> AnyPublisher<User, ServiceError>
}

class AuthentificationService: AuthentificationServiceType {
    func signInWithGoolge() -> AnyPublisher<User, ServiceError> {
        Future { [weak self] promise in 
            self?.signInWithGoolge(completion: { resut in
                switch resut {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(.serviceError))
                }
            })
            
        }.eraseToAnyPublisher()
    }

}

extension AuthentificationService {
    private func signInWithGoolge(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clienID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(AuthenticationError.clientIDError))
            return
        }
        
        let config = GIDConfiguration(clientID: clienID)
        GIDSignIn.sharedInstance.configuration = config
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            
            if let error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user, let idToken = user.idToken?.tokenString else {
                completion(.failure(AuthenticationError.tokenError))
                return
            }
            
            let accessToken = user.accessToken.tokenString
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
            
            self?.authenticateUserWithFirebase(credential: credential, completion: completion)
            
        }
    }
    
    private func authenticateUserWithFirebase(credential: AuthCredential, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(with: credential) { result, error in
            if let error {
                completion(.failure(error))
                return 
            }
            
            guard let result else {
                completion(.failure(AuthenticationError.invalidated))
                return
            }
            
            let firebaseUser = result.user
            let user: User = .init(id: firebaseUser.uid, name: firebaseUser.displayName ?? "", phoneNumber: firebaseUser.phoneNumber, profileURL: firebaseUser.photoURL?.absoluteString ?? "")
            completion(.success(user))
        }
    }
}

class StubAuthentificationService: AuthentificationServiceType {
    func signInWithGoolge() -> AnyPublisher<User, ServiceError> {
        Empty().eraseToAnyPublisher()
    }

}
