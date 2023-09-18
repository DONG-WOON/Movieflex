//
//  SignupViewController.swift
//  Movieflex
//
//  Created by 서동운 on 7/19/23.
//

import UIKit
import SnapKit
import Combine

class SignupViewController: UIViewController {
    
    private let viewModel = SignupViewModel()
    private var anyCancellable = Set<AnyCancellable>()
    
    // MARK: UI
    private let emailTextField = UITextField()
    private let emailTextFieldResultLabel = UILabel()
    private let passwordTextField = UITextField()
    private let passwordTextFieldResultLabel = UILabel()
    private let nicknameTextField = UITextField()
    
    private let locationTextField = UITextField()
    private let recommendationCodeTextField = UITextField()
    private let recommendationCodeTextFieldResultLabel = UILabel()
    private let optionalInfoLabel = UILabel()
    private let optionalInfoSwitch = UISwitch()
    private lazy var signupButton = UIButton()
    private lazy var briefSaveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
        loadUserData()
        addTargets()
        
        configureViews()
        setConstraints()
    }
    
    func bindViewModel() {
        
        viewModel.$emailValidationResult
            .sink { text in
                self.emailTextFieldResultLabel.text = text
            }.store(in: &anyCancellable)
        
        viewModel.$passwordValidationResult
            .sink { text in
                self.passwordTextFieldResultLabel.text = text
            }.store(in: &anyCancellable)
        
        viewModel.$recommendationCodeValidationResult
            .sink { text in
                self.recommendationCodeTextFieldResultLabel.text = text
            }.store(in: &anyCancellable)

        viewModel.$signupButtonIsValid
            .sink { tuple in
                let isEnabled = tuple.0 && tuple.1 && tuple.2
                self.signupButton.isEnabled = isEnabled
                self.signupButton.backgroundColor = isEnabled ? .red : .white
                self.signupButton.setTitleColor(isEnabled ? .white : .black, for: .normal)
            }.store(in: &anyCancellable)
    }
    
    @objc private func briefSaveButtonTapped(_ sender: UIButton) {
        viewModel.saveRequiredInfo()
    }
    
    @objc private func signupButtonDidTapped() {
        viewModel.signup()
        
        let alert = UIAlertController(title: "회원가입 완료", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            self.dismiss(animated: true)
        }

        alert.addAction(okAction)

        self.present(alert, animated: true)
    }
    
    fileprivate func loadUserData() {
        
        viewModel.loadUserData()
    }
    
    @objc func requiredTextFieldEditing() {
        
        viewModel.email = emailTextField.text
        viewModel.recommendationCode  = recommendationCodeTextField.text
        viewModel.password = passwordTextField.text
    }
    
    @objc func optionalInfoSwitchChanged(_ sender: UISwitch) {
        viewModel.optionalInfoIsShow = sender.isOn
    }
}


extension SignupViewController {
    
    private func addTargets() {
        signupButton.addTarget(self, action: #selector(signupButtonDidTapped), for: .touchUpInside)
        briefSaveButton.addTarget(self, action: #selector(briefSaveButtonTapped), for: .touchUpInside)
        
        [emailTextField, passwordTextField, recommendationCodeTextField].forEach { $0.addTarget(self, action: #selector(requiredTextFieldEditing), for: .editingChanged) }
        
        optionalInfoSwitch.addTarget(self, action: #selector(optionalInfoSwitchChanged), for: .valueChanged)
    }
    
    fileprivate func configureViews() {
        
        view.backgroundColor = .black
        
        view.addSubview(emailTextField)
        view.addSubview(emailTextFieldResultLabel)
        view.addSubview(passwordTextField)
        view.addSubview(passwordTextFieldResultLabel)
        view.addSubview(nicknameTextField)
        view.addSubview(locationTextField)
        view.addSubview(recommendationCodeTextField)
        view.addSubview(recommendationCodeTextFieldResultLabel)
        view.addSubview(signupButton)
        view.addSubview(briefSaveButton)
        
        view.addSubview(optionalInfoLabel)
        view.addSubview(optionalInfoSwitch)
        
        optionalInfoLabel.text = "추가정보입력"
        optionalInfoLabel.font = .systemFont(ofSize: 13)
        optionalInfoLabel.numberOfLines = 1
        optionalInfoLabel.textColor = .white
        
        signupButton.layer.cornerRadius = 8
        signupButton.clipsToBounds = true
        
        briefSaveButton.layer.cornerRadius = 8
        briefSaveButton.clipsToBounds = true
        
        emailTextFieldResultLabel.textColor = .systemBackground
        passwordTextFieldResultLabel.textColor = .systemBackground
        recommendationCodeTextFieldResultLabel.textColor = .systemBackground
        
        
        design(emailTextField, placeholder: "이메일 주소 또는 전화번호", keyboardType: .emailAddress, isSecureTextEntry: false, textAlignment: .center, borderStyle: .roundedRect, backgroundColor: .white)
        design(passwordTextField, placeholder: "비밀번호", keyboardType: .default, isSecureTextEntry: true, textAlignment: .center, borderStyle: .roundedRect, backgroundColor: .white)
        design(nicknameTextField, placeholder: "닉네임", keyboardType: .default, isSecureTextEntry: false, textAlignment: .center, borderStyle: .roundedRect, backgroundColor: .white)
        design(locationTextField, placeholder: "위치", keyboardType: .default, isSecureTextEntry: false, textAlignment: .center, borderStyle: .roundedRect, backgroundColor: .white)
        design(recommendationCodeTextField, placeholder: "추천 코드 입력", keyboardType: .numberPad, isSecureTextEntry: false, textAlignment: .center, borderStyle: .roundedRect, backgroundColor: .white)
        design(signupButton, at: .normal, title: "회원가입", titleColor: .black, backgroundColor: .white)
        design(briefSaveButton, at: .normal, title: "임시저장", titleColor: .white, backgroundColor: .red)
        design(optionalInfoSwitch, on: true, onTintColor: .red, thumbTintColor: .white)
    }
    
    fileprivate func setConstraints() {
        emailTextFieldResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField)
            make.bottom.equalTo(emailTextField.snp.top)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(50)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        passwordTextFieldResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(passwordTextField)
            make.bottom.equalTo(passwordTextField.snp.top)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        locationTextField.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        recommendationCodeTextFieldResultLabel.snp.makeConstraints { make in
            make.leading.equalTo(recommendationCodeTextField)
            make.bottom.equalTo(recommendationCodeTextField.snp.top)
        }
        recommendationCodeTextField.snp.makeConstraints { make in
            make.top.equalTo(locationTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        signupButton.snp.makeConstraints { make in
            make.top.equalTo(recommendationCodeTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        briefSaveButton.snp.makeConstraints { make in
            make.top.equalTo(signupButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
        
        optionalInfoLabel.snp.makeConstraints { make in
            make.centerY.equalTo(optionalInfoSwitch)
            make.leading.equalTo(briefSaveButton)
        }
        optionalInfoSwitch.snp.makeConstraints { make in
            make.top.equalTo(briefSaveButton.snp.bottom).offset(20)
            make.trailing.equalTo(briefSaveButton.snp.trailing)
        }
    }
    
    fileprivate func design(_ textField: UITextField,
                            placeholder: String?,
                            keyboardType: UIKeyboardType,
                            isSecureTextEntry: Bool,
                            textAlignment: NSTextAlignment,
                            borderStyle: UITextField.BorderStyle,
                            backgroundColor: UIColor?) {
        textField.placeholder = placeholder
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureTextEntry
        textField.textAlignment = textAlignment
        textField.borderStyle = borderStyle
        textField.backgroundColor = backgroundColor
        
    }
    
    fileprivate func design(_ button: UIButton, at state: UIControl.State, title: String, titleColor: UIColor, backgroundColor: UIColor) {
        button.setTitle(title, for: state)
        button.setTitleColor(titleColor, for: state)
        button.backgroundColor = backgroundColor
    }
    
    fileprivate func design(_ `switch`: UISwitch, on: Bool, onTintColor: UIColor?, thumbTintColor: UIColor?) {
        `switch`.isOn = true
        `switch`.setOn(on, animated: true)
        `switch`.onTintColor = onTintColor
        `switch`.thumbTintColor = thumbTintColor
    }
}
