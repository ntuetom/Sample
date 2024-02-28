//
//  CollectionViewCoordinator.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2024/2/14.
//

import Foundation
import RxSwift

class CollectionViewCoordinator: BaseCoordinator {
    
    override func start() {
        let collectionViewModel = CollectionViewModel()
        let collectionViewcontroller = CollectionViewController(collectionViewModel)
        
        collectionViewModel.didClickCell.subscribe(onNext: { [weak self] cellData in
            guard let self = self else {return}
            let detailCoordinator = DetailViewCoordinator(data: cellData)
            self.start(coordinator: detailCoordinator)
        }).disposed(by: disposeBag)
        navigationController.pushViewController(collectionViewcontroller, animated: true)
    }
}
