//
//  CustomFlutterError.swift
//  Runner
//
//  Created by Luka Pervan on 06.02.2024..
//

struct CustomFlutterError: Error {
    let code: String
    let message: String?
    let details: Any?
    
    init(code: String, message: String?, details: Any?) {
        self.code = code
        self.message = message
        self.details = details
    }
}
