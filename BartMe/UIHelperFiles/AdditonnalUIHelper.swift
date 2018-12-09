//
//  AdditonnalUIHelper.swift
//  BartMe
//
//  Created by Sushant Ubale on 12/7/18.
//  Copyright © 2018 Sushant Ubale. All rights reserved.
//

import Foundation
import UIKit

class AdditionalUIHelper {
    
    static func addGif(view: UIView, resource: String) {
        
        let imageData = try? Data(contentsOf: Bundle.main.url(forResource: resource, withExtension: "gif")!)
        let advTimeGif = UIImage.gifImageWithData(imageData!)
        let imageView2 = UIImageView(image: advTimeGif)
        imageView2.frame = view.frame
        view.addSubview(imageView2)
        
    }

}
