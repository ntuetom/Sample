//
//  ViewController.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/8.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import RxDataSources

class CollectionViewController: BaseViewController {

    let viewModel: CollectionViewModel
    weak var collectionView: UICollectionView!
    weak var refreshFooter: MJRefreshAutoNormalFooter!
    
    init(_ vm: CollectionViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        _ = CollectionView(vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        binding()
        initializeData()
    }
    
    func initializeData(){
        viewModel.fetchBalance() { [unowned self] balance in
            let toIntBalance = Int(balance.dropFirst(2), radix: 16) ?? 0
            let label = UILabel()
            label.numberOfLines = 0
            label.textAlignment = .center
            label.text = "balane: $\(balance) =(\(toIntBalance))"
            self.navigationItem.titleView = label
        }
        viewModel.fetchAsset()
    }
    
    func binding() {
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        
        collectionView.rx.modelSelected(CollectionData.self).bind(to: viewModel.didClickCell).disposed(by: disposeBag)
//        Observable.zip(collectionView.rx.itemSelected,
//                       collectionView.rx.modelSelected(CollectionData.self))
//            .bind
//        { [unowned self] indexPath, model in
//
//            let detailVC = DetailViewControlller(data: model)
//            navigationController?.pushViewController(detailVC, animated: true)
//        }
//        .disposed(by: disposeBag)
        
        viewModel.cellSource.subscribe { [weak self] _ in
            self?.refreshFooter?.endRefreshing()
        }.disposed(by: disposeBag)

        viewModel.cellSource
            .bind(to: collectionView.rx.items(dataSource: getDataSource()))
            .disposed(by: disposeBag)
    }
    
    func getDataSource() -> RxCollectionViewSectionedReloadDataSource<CustomSectionDataType> {
        return RxCollectionViewSectionedReloadDataSource<CustomSectionDataType>(
            configureCell: { (dataSource, cv, indexPath, item) in
              if let cell = cv.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell {
                  cell.setup(data: item)
                  return cell
              }
              return UICollectionViewCell()
          })
    }
    
    @objc func onRefresh() {
        if viewModel.hasRefreshEnd {
            refreshFooter.endRefreshingWithNoMoreData()
        } else {
            viewModel.fetchAsset()
        }
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize
    }
}

