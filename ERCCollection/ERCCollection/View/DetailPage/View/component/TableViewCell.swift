//
//  TableViewCell.swift
//  ERCCollection
//
//  Created by Apple on 2021/3/9.
//

import UIKit
import Kingfisher

protocol TableViewCellDelegate: NSObjectProtocol {
    func updateCellHeight(forExceptionImage height: CGFloat, ratio: CGFloat)
}

class TableViewCell: UITableViewCell {
    
    lazy var collectionImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.borderColor = UIColor.red.cgColor
        iv.layer.borderWidth = 1
        return iv
    }()
    
    lazy var nameLabel: UILabel = {
        let lb = makeLabel()
        return lb
    }()
    
    lazy var descLabel: UILabel = {
        let lb = makeLabel()
        return lb
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(data: TableViewCellData, delegate: TableViewCellDelegate) {
        setupConstraint()
        nameLabel.text = data.name
        descLabel.text = data.desc
        collectionImageView.setExtensionImage(data.imageURL) { [unowned self] img, error in
            if let image = img {
                let ratio = image.size.height/image.size.width
                self.collectionImageView.snp.remakeConstraints { make in
                    make.top.leading.trailing.equalToSuperview()
                    make.height.equalTo(self.collectionImageView.snp.width).multipliedBy(ratio)
                }
                layoutIfNeeded()
                let nameHeight = nameLabel.intrinsicContentSize.height
                let descHeight = descLabel.intrinsicContentSize.height
                let totalHeigt = descHeight + nameHeight + 2*kOffset
                delegate.updateCellHeight(forExceptionImage: totalHeigt, ratio: ratio)
            } else {
                print(error)
            }
        }
    }
    
    private func makeLabel() -> UILabel {
        let lb = UILabel()
        lb.textAlignment = .center
        lb.numberOfLines = 0
        lb.textColor = .black
        lb.backgroundColor = .clear
        return lb
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.addSubview(collectionImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
    }
    
    private func setupConstraint() {
        collectionImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(collectionImageView.snp.width)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview()
            make.top.equalTo(collectionImageView.snp.bottom).offset(kOffset)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(kOffset)
            make.bottom.equalToSuperview().priority(750)
        }
    }
    
}
