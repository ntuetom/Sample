//
//  Assetable.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift

protocol Assetable: NSObjectProtocol {
    func getAssets(req: GetAssetsRequest) -> Single<Result<GetAssetsSimpleResponse,ParseResponseError>>
    func getBalance(req: GetBalanceRequest) -> Single<Result<GetBalanceResponse,ParseResponseError>>
}

extension Assetable {
    func getAssets(req: GetAssetsRequest) -> Single<Result<GetAssetsSimpleResponse,ParseResponseError>> {
        return rxRequest.request(target: .fetchAssets(req: req))
    }
    func getBalance(req: GetBalanceRequest) -> Single<Result<GetBalanceResponse,ParseResponseError>> {
        return rxRequest.request(target: .getBalance(req: req))
    }
}
