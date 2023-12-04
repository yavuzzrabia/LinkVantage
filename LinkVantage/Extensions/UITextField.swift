//
//  UITextField.swift
//  LinkVantage
//
//  Created by Rabia Yavuz on 4.12.2023.
//

import UIKit

enum TextFieldTypes: String, CaseIterable {
    case nameTextField
    case surnameTextField
    case emailTextField
    case passwordTextField
    case passwordAgainTextField
    case usernameTextField
}
extension UITextField {

    func setFieldType(textField: UITextField ,type: TextFieldTypes, returnKeyType: UIReturnKeyType?, tag: Int?) {
        
        // set field tag
        if let receivedTag = tag {
            textField.tag = receivedTag
        }
        
        // set field return key type
        if let receivedReturnKeyType = returnKeyType {
            textField.returnKeyType = receivedReturnKeyType
        }
        
        // set field identifier
        textField.accessibilityIdentifier = String(describing: type)
        
        // set type
        switch type {
            case .usernameTextField:
                textField.placeholder = "Username"
                textField.keyboardType = .default
                textField.autocapitalizationType = .none
            case .nameTextField:
                textField.placeholder = "Name"
                textField.keyboardType = .default
                textField.autocapitalizationType = .words
            case .surnameTextField:
                textField.placeholder = "Surname"
                textField.keyboardType = .default
                textField.autocapitalizationType = .words
            case .emailTextField:
                textField.placeholder = "Email"
                textField.keyboardType = .emailAddress
                textField.autocapitalizationType = .none
            case .passwordTextField:
                textField.placeholder = "Password"
                textField.keyboardType = .default
                textField.autocapitalizationType = .none
                textField.isSecureTextEntry = true
            case .passwordAgainTextField:
                textField.placeholder = "Password again"
                textField.keyboardType = .default
                textField.autocapitalizationType = .none
                textField.isSecureTextEntry = true
            
        }
    }
}
