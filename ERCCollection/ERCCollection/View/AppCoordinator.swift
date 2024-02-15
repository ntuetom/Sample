//
//  AppCoordinator.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2024/2/14.
//

import Foundation
import RxSwift

class AppCoordinator: BaseCoordinator {

    override func start() {
        let coordinator = CollectionViewCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
        
        if #available(iOS 14.0, *) {
            var bgConfig = UIBackgroundConfiguration.listPlainCell()
            bgConfig.backgroundColor = UIColor.white
            UITableViewHeaderFooterView.appearance().backgroundConfiguration = bgConfig
        }
        
    }
}
