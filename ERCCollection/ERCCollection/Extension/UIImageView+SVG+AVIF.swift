//
//  UIImageView+SVG+AVIF.swift
//  ERCCollection
//
//  Created by Wu hung-yi on 2024/1/28.
//

import UIKit
import Kingfisher
import SDWebImage
import SDWebImageAVIFCoder

extension UIImageView {
    func setExtensionImage(_ _url: URL?, completion: ((_ image: UIImage?, _ error: Error?)->Void)? = nil) {
        guard let url = _url else {
            return
        }
        var options: KingfisherOptionsInfo?
        if url.relativeString.hasSuffix(".svg") {
            options = [.processor(SVGImgProcessor())]
        } else if url.relativePath.hasSuffix(".avif") {
            let AVIFCoder = SDImageAVIFCoder.shared
            SDImageCodersManager.shared.addCoder(AVIFCoder)
            sd_setImage(with: url, completed: {img,error,_,_ in
                completion?(img,error)
            })
            return
        }
        kf.setImage(with: url, options: options, completionHandler:  { response in
            switch response {
            case .success(let img):
                completion?(img.image, nil)
            case .failure(let error):
                completion?(nil, error)
            }
        })
    }
}
