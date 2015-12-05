//
//  TableViewSingleSelection.swift
//  WordBuzz
//
//  Created by verec on 02/12/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import Foundation
import UIKit

class TableViewSingleSelection {

    let tableView:          UITableView
    var selectedIndexPath:  NSIndexPath? = .None

    typealias ClearSelection    =   (NSIndexPath) -> (Bool)
    typealias ToggleSelection   =   (NSIndexPath) -> ()

    var clearSelection:ClearSelection?      =   .None
    var toggleSelection:ToggleSelection?    =   .None

    init(tableView: UITableView) {
        self.tableView = tableView
    }

    func selectionChanged(indexPath: NSIndexPath) {

        tableView.endEditing(true)
        let deselect:Bool
        var toReload:[NSIndexPath] = []

        if  let lastSelectedIndexPath = self.selectedIndexPath {

            deselect = lastSelectedIndexPath.row == indexPath.row
            self.selectedIndexPath = .None

            if let didIt = clearSelection?(lastSelectedIndexPath) where didIt {
                toReload.append(lastSelectedIndexPath)
            }
        } else {
            deselect = false
        }

        if !deselect {
            self.selectedIndexPath = indexPath

            self.toggleSelection?(indexPath)

            toReload.append(indexPath)
        }


//        let mode: UITableViewRowAnimation = .Automatic
//        let mode: UITableViewRowAnimation = .None
//        let mode: UITableViewRowAnimation = .Middle
//        let mode: UITableViewRowAnimation = .Fade
        let mode: UITableViewRowAnimation = .Automatic
        tableView.reloadRowsAtIndexPaths(toReload, withRowAnimation: mode)
        if let ip = toReload.last {
            tableView.scrollToRowAtIndexPath(ip, atScrollPosition: .None, animated: true)
        }
    }
}