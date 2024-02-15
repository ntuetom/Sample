//
//  DetailCoordinator.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2024/2/14.
//

import UIKit

class DetailViewCoordinator: BaseCoordinator {
    
    let data: CollectionData
    init(data: CollectionData) {
        self.data = data
    }
    
    override func start() {
        let viewModel = DetailViewModel(data: data)
        let detailViewcontroller = DetailViewControlller(viewModel)
        
        viewModel.didTapWebButton.subscribe(onNext: { url in
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }).disposed(by: disposeBag)
        navigationController.pushViewController(detailViewcontroller, animated: true)
    }
}
