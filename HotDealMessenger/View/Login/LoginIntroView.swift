//
//  LoginIntroView.swift
//  HotDealMessenger
//
//  Created by 김준건 on 2024/01/15.
//

import SwiftUI

struct LoginIntroView: View {
    @State private var isPresentedLoginView: Bool = false
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                Text("환영합니다.")
                    .font(.system(size:26, weight: .bold))
                    .foregroundColor(.black)
                Text("매일 핫딜 관련된 정보를 부담없이 받아보세요!")
                    .font(.system(size: 12))
                    .foregroundColor(.grayDeep)
                
                Spacer()
                Button {
                    isPresentedLoginView.toggle()
                } label: {
                    Text("로그인")
                        .font(.system(size:14))
                        .foregroundColor(.bkText)
                        .frame(maxWidth: .infinity, maxHeight: 40)
                }.buttonStyle(LoginButtonStyle(textColor: .lineAppColor))
            }
            .navigationDestination(isPresented: $isPresentedLoginView) { 
                LoginView()
            }
            
     
        }
    }
}

struct LoginIntroView_Previews: PreviewProvider {
    static var previews: some View {
        LoginIntroView()
    }
}
