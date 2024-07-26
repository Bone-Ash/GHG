//
//  Crypto.swift
//  Monut
//
//  Created by GH on 7/23/24.
//

import Foundation
import CryptoSwift

/// `CryptoManager` 结构体提供了加密操作的封装方法。
public struct CryptoManager {
    /// 非对称密钥生成函数
    /// - Parameters:
    ///   - publicTag: 公钥标识
    ///   - privateTag: 私钥标识
    /// - Returns: 公钥与私钥
    ///
    /// - Author: GH
    public static func generateKeyPair(publicTag: String, privateTag: String) -> (publicKey: SecKey?, privateKey: SecKey?) {
        let keySize = 2048
        
        let privateKeyParameters: [String: Any] = [
            kSecAttrIsPermanent as String: true,
            kSecAttrApplicationTag as String: privateTag,
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeySizeInBits as String: keySize
        ]
        
        var error: Unmanaged<CFError>?
        
        guard let privateKey = SecKeyCreateRandomKey(privateKeyParameters as CFDictionary, &error) else {
            print("Failed to generate private key: \((error?.takeRetainedValue()) as Error?)")
            return (nil, nil)
        }
        
        guard let publicKey = SecKeyCopyPublicKey(privateKey) else {
            print("Failed to extract public key from private key")
            return (nil, nil)
        }
        
        return (publicKey, privateKey)
    }
    
    /// 加载本地公钥
    /// - Parameter pemFileName: pem 文件名
    /// - Returns: SecKey 类型公钥
    ///
    /// - Author: GH
    public static func loadPublicKey(from pemFileName: String) -> SecKey? {
        guard let pemFilepath = Bundle.main.path(forResource: pemFileName, ofType: "pem"),
              let pemString = try? String(contentsOfFile: pemFilepath, encoding: .utf8) else {
            print("Failed to load PEM file")
            return nil
        }
        
        let base64String = base64FromPEM(pemString)
        
        guard let data = Data(base64Encoded: base64String) else {
            print("Failed to decode base64")
            return nil
        }
        
        let options: [String: Any] = [
            kSecAttrKeyType as String: kSecAttrKeyTypeRSA,
            kSecAttrKeyClass as String: kSecAttrKeyClassPublic
        ]
        
        var error: Unmanaged<CFError>?
        
        guard let publicKey = SecKeyCreateWithData(data as CFData, options as CFDictionary, &error) else {
            print("Failed to create public key: \(error?.takeRetainedValue() as Error?)")
            return nil
        }
        
        return publicKey
    }
    
    /// 使用公钥加密`Data`
    /// - Parameters:
    ///   - data: 待加密数据
    ///   - publicKey: 公钥
    /// - Returns: 密文
    ///
    /// - Author: GH
    public static func encrypt(data: Data, with publicKey: SecKey) -> Data? {
        let algorithm: SecKeyAlgorithm = .rsaEncryptionOAEPSHA1
        
        guard SecKeyIsAlgorithmSupported(publicKey, .encrypt, algorithm) else {
            print("Algorithm not supported.")
            return nil
        }
        
        var error: Unmanaged<CFError>?
        
        guard let cipherData = SecKeyCreateEncryptedData(publicKey, algorithm, data as CFData, &error) else {
            if let error = error {
                print("Encryption error: \(error.takeRetainedValue())")
            }
            return nil
        }
        return cipherData as Data
    }
    
    /// 使用公钥加密`String`，将调用公钥加密数据函数
    /// - Parameters:
    ///   - string: 待加密字符串
    ///   - publicKey: 公钥
    /// - Returns: 密文
    ///
    /// - Author: GH
    public static func encrypt(string: String, with publicKey: SecKey) -> Data? {
        guard let data = string.data(using: .utf8) else {
            print("Error: Unable to convert string to Data")
            return nil
        }
        
        return encrypt(data: data, with: publicKey)
    }
    
    /// 生成基于 HMAC-SHA-256 的消息认证码
    /// - Parameters:
    ///   - message: 待加密的数据
    ///   - secret: 密钥
    /// - Returns: 密文
    ///
    /// - Author: GH
    public static func hmacSHA256(_ message: String, secret: String) -> String? {
        do {
            let hmac = try HMAC(key: secret.bytes, variant: .sha2(.sha256)).authenticate(Array(message.utf8))
            let hmacData = Data(hmac)
            let base64UrlEncoded = hmacData.base64UrlEncodedString()
            
            return base64UrlEncoded
        } catch {
            print("HMAC generation error: \(error)")
            return nil
        }
    }
}
