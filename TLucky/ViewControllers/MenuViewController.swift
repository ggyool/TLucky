//
//  MenuViewController.swift
//  TLucky
//
//  Created by Tony Jung on 2020/10/30.
//

import UIKit

enum MenuType: Int {
    case home
    case profile
    case camera
}

class MenuViewController: UITableViewController {
    
    var didTapMenuType: ((MenuType) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let menuType = MenuType(rawValue: indexPath.row) else { return }
        dismiss(animated: true) { [weak self] in //to avoid error
            print("Dismissing: \(menuType)")
            self?.didTapMenuType?(menuType)
        }
    }

}
