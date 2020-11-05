//
//  FoodType.swift
//  TLucky
//
//  Created by ggyool on 2020/11/05.
//

import Foundation
import UIKit

let chestNutImage: UIImage? = UIImage(named: "chestNut")
let tteokbokkiImage: UIImage? = UIImage(named: "tteokbokki")
let takoyakiImage: UIImage? = UIImage(named: "takoyaki")
let chinesePancakeImage: UIImage? = UIImage(named: "chinesePancake")

enum Food: String, Codable {
    case chestNut = "군밤"
    case sweetPotato = "군고구마"
    case tteokbokki = "떡볶이"
    case chinesePancake = "호떡"
    case takokayki = "타코야끼"
    case fishBun = "붕어빵"
    
    func getImage() -> UIImage? {
        switch self {
        case .chestNut:
            return chestNutImage
        case .tteokbokki:
            return tteokbokkiImage
        case .takokayki:
            return takoyakiImage
        case .chinesePancake:
            return chinesePancakeImage
        default:
            return nil
        }
    }
}
