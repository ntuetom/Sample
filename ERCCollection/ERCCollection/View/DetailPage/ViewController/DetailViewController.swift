//
//  DetailViewController.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import UIKit
import RxSwift

class DetailViewControlller: BaseViewController {
    
    let viewModel: DetailViewModel
    var detailView: DetailView!
    weak var tableView: UITableView!
    
    init(_ vm: DetailViewModel) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        print("DetailViewControlller deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        detailView = DetailView(title: viewModel.collectionData.collectionName, vm: viewModel, owner: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        binding()
        viewModel.emitData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(false, animated: false)
        navigationItem.titleView = detailView.navTitleLabel
    }
    
    func binding() {
        navigationController?.delegate = self
        viewModel
            .cellSource
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "TableViewCell", cellType: TableViewCell.self)) {index, element, cell in
                cell.setup(data:  element, delegate: self)
            }
            .disposed(by: disposeBag)
        
        detailView.webButton.rx.tap.subscribe { [weak self] _ in
            if let url = self?.viewModel.collectionData.webURL {
                self?.viewModel.didTapWebButton.onNext(url)
            }
        }.disposed(by: disposeBag)
    }
}
extension DetailViewControlller: TableViewCellDelegate, UINavigationControllerDelegate {
    
    func updateCellHeight(forExceptionImage height: CGFloat, ratio: CGFloat){
        if tableView.frame.height != height {
            self.tableView.reloadItemsAtIndexPaths([IndexPath(row: 0, section: 0)], animationStyle: .automatic)
            self.detailView.updateTableViewConstraint(for: height+tableView.frame.width*ratio)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let coordinator = navigationController.topViewController?.transitionCoordinator {
            if coordinator.isInteractive {
                coordinator.notifyWhenInteractionChanges { [weak self] (context) in
                    if !context.isCancelled {
                        self?.viewModel.didPopBack.onNext(())
                    }
                }
                
            } else if viewController !== self {
                viewModel.didPopBack.onNext(())
            }
        }
    }
}
