//
//  Macros.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2021/3/6.
//

import UIKit

// MARK: - 螢幕配置
let ownerEthereum = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
let api_key = "q2DisUJXQaP52A6VDut5Z9nUfk041DpR"
let kScreenH: CGFloat = UIScreen.main.bounds.size.height
let kScreenW: CGFloat = UIScreen.main.bounds.size.width
@available(iOS 11.0, *)
let kInset: UIEdgeInsets?  = UIApplication.shared.windows.first?.safeAreaInsets

var kSafeAreaStatusHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return kInset?.top ?? 44
    } else {
        return 20
    }
}
var kSafeAreaBottomHeight: CGFloat {
    if #available(iOS 11.0, *) {
        return kInset?.bottom ?? 34
    } else {
        return 0
    }
}
let kSafeAreaHeight:       CGFloat = kSafeAreaStatusHeight + kSafeAreaBottomHeight

// MARK: - 畫面變數
let kOffset: CGFloat = 10
