//
//  Extension+UITableView.swift
//  iOSCcodeGeneral
//
//  Created by administrator on 12/17/19.
//  Copyright © 2019 Vision. All rights reserved.
//

import UIKit

let RefreshControlTag = 19911992

extension UITableView {
    //MARK: - REGISTER Cell
    func registerCellWithNibName(_ name: String) {
        self.register(UINib(nibName: name, bundle: Bundle.main), forCellReuseIdentifier: name)
    }
    
    //MARK: - Scroll To Bottom
    func scrollToBottom(animated: Bool){
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
        }
    }
    
    //MARK: - Scroll To Top
    func scrollToTop(animated: Bool) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: animated)
        }
    }
    
    //MARK: - Add Pull To RefreshControl TableView
    func pullToRefresh(target: Any, selector: Selector) {
        let control = UIRefreshControl()
        control.tag = RefreshControlTag
        control.addTarget(target, action: selector, for: .valueChanged)
        control.attributedTitle = NSAttributedString(string: "Kéo xuống để tải lại dữ liệu")
        self.addSubview(control)
    }
    
    //MARK: - Stop Pull To RefreshControl TableView
    func stopRefresh() {
        for subview in self.subviews {
            if subview.tag == RefreshControlTag {
                (subview as! UIRefreshControl).endRefreshing()
            }
        }
    }
    
    //MARK: - Remove Line And Dynamic Cell
    func removeLineAndDynamicCell() {
        self.separatorStyle = .none
        self.estimatedRowHeight = 44
        self.rowHeight = UITableView.automaticDimension
    }
    
}
