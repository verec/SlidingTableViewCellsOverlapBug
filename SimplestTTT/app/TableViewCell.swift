//
//  TableViewCell.swift
//  SimplestTTT
//
//  Created by verec on 05/12/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import Foundation
import UIKit

class TableViewCell : UITableViewCell {

    private let label = UILabel()
    private let secret = UILabel()

    typealias JustHeatupMachine = ()->()
    var tapped:JustHeatupMachine? = .None

    var min:CGFloat = 10.0
    var max:CGFloat = 20.0

    var model:Model? {
        didSet {
            if let m = model {
                label.text = "Model #\(m.rank)"
            } else {
                label.text = "???"
            }
            self.applyColor()
            self.setNeedsLayout()
        }
    }

    func applyColor() {
        if let m = model {

            let color   = m.rank & 1 == 0
                        ? UIColor.yellowColor().colorWithAlphaComponent(0.5)
                        : UIColor.blueColor().colorWithAlphaComponent(0.5)

            self.contentView.backgroundColor = color
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Default, reuseIdentifier: reuseIdentifier)

        super.backgroundColor = UIColor.clearColor()

        super.selectedBackgroundView = nil
        super.backgroundView = nil

        self.contentView.addSubview(label)
        setupLabel(label)

        self.contentView.addSubview(secret)
        setupLabel(secret)

        secret.text = "Only revealed when expanded"

        setupTapRecognizer()

        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Gestures
extension TableViewCell {

    func setupTapRecognizer() {
        let reco = UITapGestureRecognizer()
        reco.addTarget(self, action: Selector("tapped:"))
        self.addGestureRecognizer(reco)
    }

    func tapped(reco:UITapGestureRecognizer) {
        if reco.state == .Ended {
            if let tapped = self.tapped {
                tapped()
            }
        }
    }
}

// MARK: setup
extension TableViewCell {

    func setupLabel(label: UILabel) {
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Center
        label.numberOfLines = 1
        label.lineBreakMode = .ByTruncatingMiddle

    }
}

// MARK: Layout
extension TableViewCell {

    override func layoutSubviews() {
        super.layoutSubviews()

        label.sizeToFit()
        label.frame = label.bounds.centered(intoRect: self.bounds)

        secret.sizeToFit()
        secret.frame.origin = CGPoint(x: 0.0, y: self.max - 22.0)
    }
}

// MARK: Cell selection override
extension TableViewCell {

    override func setSelected(selected: Bool, animated: Bool) {
        /// we handle the selection ourself
    }

    override func setHighlighted(highlighted: Bool, animated: Bool) {
        /// we handle the hilight ourself
    }
}
