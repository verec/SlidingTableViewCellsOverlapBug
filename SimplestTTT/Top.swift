//
//  Top.swift
//  Wordbuzz
//
//  Created by verec on 31/10/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import UIKit

struct Top {

    class DefaultWindow :UIWindow {
        override func layoutSubviews() {
            super.layoutSubviews()

            Top.mainView.frame = self.bounds
        }
    }

    class DefaultView :UIView {
        override func layoutSubviews() {
            super.layoutSubviews()

            for view in self.subviews {
                view.frame = self.bounds
            }
        }
    }

    class DefaultController : UIViewController {
        override func shouldAutorotate() -> Bool {
            return true
        }
        override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
            return [.PortraitUpsideDown, .Portrait]
        }
    }

    static var defaultView:UIView       =   DefaultView()

    static var mainView                 =   defaultView
    static let defaultWindow            =   DefaultWindow(frame: UIScreen.mainScreen().bounds)
    static let defaultController        =   DefaultController()
}

