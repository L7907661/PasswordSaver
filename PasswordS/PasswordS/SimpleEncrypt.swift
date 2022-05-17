//
//  SimpleEncrypt.swift
//  PasswordS
//
//  Created by Zeyu Liao on 5/15/22.
//

import Foundation
import CryptoSwift
import RNCryptor
//from https://stackoverflow.com/questions/46479514/swift-encrypt-and-decrypt-a-string-using-a-users-password
class SimpleEncrypt{
    var p: String?
    var key: String?
    static let shared = SimpleEncrypt()
    func encryptMessage(message: String, encryptionKey: String) -> String {
        let messageData = message.data(using: .utf8)!
        let cipherData = RNCryptor.encrypt(data: messageData, withPassword: encryptionKey)
        return cipherData.base64EncodedString()
    }

    func decryptMessage(encryptedMessage: String, encryptionKey: String) throws -> String {
        do{
            let encryptedData = Data.init(base64Encoded: encryptedMessage)!
//            let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: "hAfY")

            let decryptedData = try RNCryptor.decrypt(data: encryptedData, withPassword: encryptionKey)
            let decryptedString = String(data: decryptedData, encoding: .utf8)!
    //        print(decryptedString)
            return decryptedString
        } catch {
            return "decryptMessage FAILED"
        }
       
    }

}
