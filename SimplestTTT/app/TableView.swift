//
//  TableView.swift
//  SimplestTTT
//
//  Created by verec on 05/12/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import Foundation
import UIKit

class TableView : UITableView {

    struct Parameters {
        static let cellIdentifier                   = NSStringFromClass(TableViewCell.self)
        static let cellClass                        = TableViewCell.self
    }

    var singleSelection:TableViewSingleSelection? = .None

    convenience init() {
        self.init(frame: CGRect.zero, style: .Plain)
    }

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)

        self.singleSelection = TableViewSingleSelection(tableView: self)

        self.delegate = self
        self.dataSource = self

        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        self.separatorStyle = .None
        self.indicatorStyle = .White
        // step 1/2 to enable "delete"
        self.allowsMultipleSelectionDuringEditing = false

        self.backgroundColor = UIColor.clearColor()

        self.registerClass(Parameters.cellClass, forCellReuseIdentifier: Parameters.cellIdentifier)

        self.setupClearSingleSelection()
        self.setupToggleSingleSelection()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TableView {

    func setupClearSingleSelection() {
        self.singleSelection?.clearSelection = {

            let ip = $0

            if ip.row < Storage.modelSource.count {
                let model = Storage.modelSource[ip.row]
                model.expanded = false
                return true
            }
            return false
        }
    }

    func setupToggleSingleSelection() {
        self.singleSelection?.toggleSelection = {
            let ip = $0
            let model = Storage.modelSource[ip.row]
            model.expanded = !model.expanded
        }
    }
}

extension TableView : UITableViewDataSource {

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = self.dequeueReusableCellWithIdentifier(Parameters.cellIdentifier, forIndexPath: indexPath) as! TableViewCell

        let index   = indexPath.row
        let model   = Storage.modelSource[index]
        cell.min    = self.collaspedRowHeight()
        cell.max    = self.expandedHeight()
        cell.model  = model

        func tapped() {
            if let singleSelection = self.singleSelection {
                singleSelection.selectionChanged(indexPath)
            }
        }

        cell.tapped = MultiDispatch(tapped).call

        return cell
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.modelSource.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

extension TableView : UITableViewDelegate {

    func collaspedRowHeight() -> CGFloat {
        return 48.0
    }

    func expandedHeight() -> CGFloat {
        return collaspedRowHeight() * 3.0
    }

    func tableView(             tableView:  UITableView
    ,   heightForRowAtIndexPath indexPath:  NSIndexPath) -> CGFloat {
        let storage = Storage.modelSource
        let model = storage[indexPath.row]

        return model.expanded ? expandedHeight() : collaspedRowHeight()
    }
}

