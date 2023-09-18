//
//  SignupViewModel.swift
//  Movieflex
//
//  Created by 서동운 on 9/13/23.
//

import Foundation
import Combine

enum TextError: Error {
    case textIsEmpty
    case formatInvalid
}

class SignupViewModel {
    @Published var email: String?
    @Published var password: String?
    @Published var nickname: String?
    @Published var emailValidationResult: String?
    @Published var passwordValidationResult: String?
    @Published var recommendationCodeValidationResult: String?
    @Published var location: String?
    @Published var recommendationCode: String?
    @Published var optionalInfoIsShow: Bool
    @Published var signupButtonIsValid: (emailValid: Bool, passwordValid: Bool, codeValid: Bool) = (false, false, false)
    

    private var anyCancellable = Set<AnyCancellable>()
    
    init(id: String? = nil, password: String? = nil, nickname: String? = nil, location: String? = nil, recommendationCode: String? = nil, optionalInfoIsShow: Bool = false) {
        self.email = id
        self.password = password
        self.nickname = nickname
        self.location = location
        self.recommendationCode = recommendationCode
        self.optionalInfoIsShow = optionalInfoIsShow
        
        $email
            .sink { email in
                let isValid = self.validateEmail(email)
                self.signupButtonIsValid.emailValid = isValid
            }
            .store(in: &anyCancellable)
        
        $password
            .sink { password in
                let isValid = self.validatePassword(password)
                self.signupButtonIsValid.passwordValid = isValid
            }.store(in: &anyCancellable)
        
       $recommendationCode
            .sink { code in
                let isValid = self.validateRecommendationCode(code)
                self.signupButtonIsValid.codeValid = isValid
            }.store(in: &anyCancellable)
        
    }
    
    func saveRequiredInfo() {
        UserDefaults.standard.setValue(email, forKey: "id")
        UserDefaults.standard.setValue(password, forKey: "password")
        UserDefaults.standard.setValue(nickname, forKey: "nickname")
    }
    
    func validateEmail(_ text: String?) -> Bool {
        guard let email = text, !email.isEmpty else {
            emailValidationResult = "이메일을 입력해주세요"
            return false
        }
        guard let _ = email.range(of: "^([A-Za-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,})$", options: .regularExpression) else {
            emailValidationResult = "이메일을 movie@mov.com 형식으로 입력해주세요"
            return false }
        emailValidationResult = "이메일 유효"
        return true
    }
    
    func validatePassword(_ text: String?) -> Bool {
        guard let password = text else { passwordValidationResult = "패스워드를 입력해주세요"
            return false
        }
        guard password.count <= 10 && password.count >= 6 else { passwordValidationResult = "6자 이상 10자 이하로 설정해주세요."
            return false
        }
        passwordValidationResult = "패스워드 유효"
        return true
    }
    
    func validateRecommendationCode(_ text: String?) -> Bool {
        guard let recommendationCode = text else { recommendationCodeValidationResult = "추천코드를 입력해주세요"
            return false
        }
        guard recommendationCode.count == 6 else { recommendationCodeValidationResult = "추천코드를 정확하게 입력해주세요."
            return false
        }
        recommendationCodeValidationResult = "추천코드 유효"
        return true
    }
    
    func signup() {
        
    }
    
    
    func loadUserData() {
        let id = UserDefaults.standard.string(forKey: "id")
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let password = UserDefaults.standard.string(forKey: "password")

        self.email = id
        self.nickname = nickname
        self.password = password
    }
}
