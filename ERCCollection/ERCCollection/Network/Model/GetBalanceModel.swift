//
//  GetBalanceModel.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2024/1/27.
//

import Foundation

struct GetBalanceRequest: Encodable {
    let jsonrpc: String
    let id: Int
    let params: [String]
    let method: String
}

struct GetBalanceResponse: Decodable {
    let jsonrpc: String
    let id: Int
    let result: String
}
