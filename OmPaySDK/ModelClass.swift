//
//  ModelClass.swift
//  OmPaySDK
//
//  Created by mac on 20/07/23.
//

import Foundation

// MARK: - ClientTokenModel
struct ClientTokenModel: Codable {
    let accessToken, tokenType: String
    let expiresOn, issuedOn: Date
}
