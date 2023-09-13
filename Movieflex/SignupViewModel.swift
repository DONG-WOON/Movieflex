//
//  SignupViewModel.swift
//  Movieflex
//
//  Created by 서동운 on 9/13/23.
//

import Foundation

class SignupViewModel {
    @Published var id: String?
    @Published var password: String?
    @Published var nickname: String?
    @Published var location: String?
    @Published var recommendationCode: String?
    @Published var optionalInfoIsShow: Bool
    @Published var signupButtonIsValid: Bool = false
    
    init(id: String? = nil, password: String? = nil, nickname: String? = nil, location: String? = nil, recommendationCode: String? = nil, optionalInfoIsShow: Bool = false) {
        self.id = id
        self.password = password
        self.nickname = nickname
        self.location = location
        self.recommendationCode = recommendationCode
        self.optionalInfoIsShow = optionalInfoIsShow
    }
    
    func saveRequiredInfo() {
        UserDefaults.standard.setValue(id, forKey: "id")
        UserDefaults.standard.setValue(password, forKey: "password")
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
    }
    
    func validateRequiredInfo() {
        guard let id, let password, let nickname else { return }
        if id.count >= 6 && password.count >= 7 && nickname.count >= 5 {
            signupButtonIsValid = true
        } else {
            signupButtonIsValid = false
        }
    }
    
    func signup() {
        
    }
    
    func loadUserData() {
        let id = UserDefaults.standard.string(forKey: "id")
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let password = UserDefaults.standard.string(forKey: "password")

        self.id = id
        self.nickname = nickname
        self.password = password
    }
}
