//
//  SettingViewController.swift
//  Shopping_Stock_List
//
//  Created by 光岡駿 on 2019/11/08.
//  Copyright © 2019 光岡駿. All rights reserved.
//

import UIKit

class SettingViewController: SuperViewController_List {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //cellの表示設定
    override func CellView(indexpath:IndexPath) -> UIView {
        let cell_view:UIView = settingCellView(indexpath: indexpath)
        return cell_view
    }
    
    override func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return ViewProperties.SettingheaderView(section: section)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return ViewProperties.settingHeaderHeight
    }
    
    //cell選択時segue
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                performSegue(withIdentifier: "Category_setting", sender: nil)
            default:
                return
            }
        default:
            return
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
}
