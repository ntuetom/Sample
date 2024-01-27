//
//  GetAssetsResponse.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import Foundation

struct GetAssetsRequest: Encodable {
    let pageKey: String?
    let pageSize: Int
    let owner: String
    
    init(pageSize: Int = 20, owner: String = ownerEthereum, pageKey: String? = nil) {
        self.pageSize = pageSize
        self.owner = owner
        self.pageKey = pageKey
    }
}

struct GetAssetsSimpleResponse: Decodable {
    let ownedNfts: [NFTSimpleEntity]
    let totalCount: Int
    let pageKey: String?
}

struct NFTSimpleEntity: Decodable {
    let contract: ContractSimpleEntity
    let tokenId: String
    let name: String
    let description: String
    let image: ImageSimpleEntity
}

struct ContractSimpleEntity: Decodable {
    let address: String
    let name: String
}

struct ImageSimpleEntity: Decodable {
    let originalUrl: String
}

struct GetAssetsResponse: Decodable {
    let ownedNfts: [NFTEntity]
    let totalCount: Int
    let validAt: ValidData
    let pageKey: String?
}

struct NFTEntity: Decodable {
    let contract: ContractEntity
    let tokenId: String
    let tokenType: String
    let name: String
    let description: String
    let image: ImageEntity
    let raw: RawEntity
    let tokenUri: String
    let timeLastUpdated: String
    let balance: String
}

struct ValidData: Decodable {
    let blockNumber: Int
    let blockHash: String
    let blockTimestamp: String
}

struct ContractEntity: Decodable {
    let address: String
    let name: String
    let symbol: String
    let totalSupply: String
    let tokenType: String
    let contractDeployer: String
    let deployedBlockNumber: Int
    let openSeaMetadata: openSeaMetaEntity
    let isSpam: Bool?
    let spamClassifications: [String]
}

struct ImageEntity: Decodable {
    let cachedUrl: String
    let thumbnailUrl: String
    let pngUrl: String
    let contentType: String
    let size: Int
    let originalUrl: String
}

struct RawEntity: Decodable {
    let tokenUri: String?
    let metadata: MetaEntity
    let error: String?
}

struct MetaEntity: Decodable {
    let name: String
    let description: String
    let image: String
    let external_url: String
    let attributes: [AttributeEntity]
}

struct AttributeEntity: Decodable {
    let value: String
    let trait_type: String
}

struct openSeaMetaEntity: Decodable {
    let floorPrice: Double?
    let collectionName: String
    let safelistRequestStatus: String
    let imageUrl: String
    let description: String
    let externalUrl: String
    let twitterUsername: String
    let discordUrl: String
    let lastIngestedAt: String
}
