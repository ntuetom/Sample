//
//  CollectionViewModel.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import RxSwift
import RxDataSources

class CollectionViewModel: NSObject, Assetable {
    
    let disposeBag = DisposeBag()
    let cellSize: CGSize
    var offset = 0
    var limit = 20
    var cellSource = PublishSubject<[CustomSectionDataType]>()
    var didClickCell = PublishSubject<CollectionData>()
    var collectionDatas: [CollectionData] = []
    var pageKey: String?
    var totalCount: Int
    
    var hasRefreshEnd: Bool {
        guard totalCount > collectionDatas.count else {
            print("所有作品加載完畢")
            return true
        }
        return false
    }
    override init() {
        let w = (kScreenW-3*kOffset)/2
        cellSize = CGSize(width: w, height: w)
        totalCount = 1
        super.init()
    }
    
    func fetchBalance(onSuccess: @escaping (String)->Void) {
        getBalance(req: GetBalanceRequest(jsonrpc: "2.0", id: 1, params: [ownerEthereum,"latest"], method: "eth_getBalance")).subscribe(onSuccess: {response in
            switch response {
            case .success(let data):
                onSuccess(data.result)
                print(data)
             
            case .failure(let error):
                print(error.message)
            }
        }, onError: { error in
            self.cellSource.onNext([])
            print(error)
        })
        .disposed(by: disposeBag)
    }
    
    func fetchAsset() {
        let request = GetAssetsRequest(pageKey: pageKey)
        getAssets(req: request)
            .subscribe(onSuccess: { [unowned self] response in
                switch response {
                case .success(let data):
                    print(data)
                    self.pageKey = data.pageKey
                    self.totalCount = data.totalCount
                    let temp = data.ownedNfts.enumerated().map { (index, asset) -> CollectionData in
                        let permalink = "https://testnets.opensea.io/assets/goerli/\(asset.contract.address)/\(asset.tokenId)"
                        return CollectionData(id: offset + index, name: asset.name, img_url: URL(string: asset.image.originalUrl), image_preview_url: URL(string: asset.image.originalUrl), description: asset.description, collectionName: asset.contract.name, webURL: URL(string: permalink))
                    }
                    self.collectionDatas.append(contentsOf: temp)
                    self.cellSource.onNext([CustomSectionDataType(uniqueId: "", items: collectionDatas)])
                    self.offset += self.limit
                case .failure(let error):
                    self.cellSource.onNext([])
                    print(error.message)
                }
            }, onError: { error in
                self.cellSource.onNext([])
                print(error)
            })
            .disposed(by: disposeBag)
    }
}
