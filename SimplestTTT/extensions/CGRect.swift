//
//  CGRect.swift
//  Wordbuzz
//
//  Created by verec on 22/08/2015.
//  Copyright © 2015 Cantabilabs Ltd. All rights reserved.
//

import CoreGraphics
import UIKit.UIGeometry

extension CGRect {

    func positionned(intoRect r: CGRect, widthUnitRatio wu: CGFloat, heightUnitRatio hu: CGFloat) -> CGRect {

        let size:CGSize        = r.size
        let center:CGPoint     = CGPoint(x: r.minX + size.width * wu
                                    ,    y: r.minY + size.height * hu)
        var rect = self
        rect.origin.x = center.x - (rect.width / 2.0)
        rect.origin.y = center.y - (rect.height / 2.0)

        return rect
    }

    func centered(intoRect intoRect: CGRect) -> CGRect {
        return self.positionned(intoRect: intoRect, widthUnitRatio: 0.5, heightUnitRatio: 0.5)
    }
}

extension CGRect {

    func width(forcedWidth:CGFloat) -> CGRect {
        var rect = self
        rect.size.width = forcedWidth
        return rect
    }

    func height(forcedHeight:CGFloat) -> CGRect {
        var rect = self
        rect.size.height = forcedHeight
        return rect
    }
}

extension CGRect {

    func top(offset: CGFloat, size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y = offset
        rect.size.height = size
        return rect
    }

    func top(size: CGFloat) -> CGRect {
        var rect = self
        rect.size.height = size
        return rect
    }

    func left(offset: CGFloat, size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = offset
        rect.size.width = size
        return rect
    }

    func left(size: CGFloat) -> CGRect {
        var rect = self
        rect.size.width = size
        return rect
    }

    func bottom(offset: CGFloat, size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y = rect.size.height - (offset + size)
        rect.size.height = size
        return rect
    }

    func bottom(size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.y += self.size.height - size
        rect.size.height = size
        return rect
    }

    func right(offset: CGFloat, size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x = rect.size.width - (offset + size)
        rect.size.width = size
        return rect
    }

    func right(size: CGFloat) -> CGRect {
        var rect = self
        rect.origin.x += rect.size.width - size
        rect.size.width = size
        return rect
    }
}

extension CGRect {

    var center:CGPoint {
        return CGPoint(x: self.midX, y:self.midY)
    }
}

extension CGRect {

    func rowInBetween(other: CGRect) -> CGRect {
        var rect = self
        rect.size.height = other.minY - rect.maxY
        rect.origin.y = self.maxY
        return rect
    }
}

extension CGRect {

    func grow(edge:UIRectEdge, by: CGFloat) -> CGRect {

        var rect = self
        
        if edge == .Top {
            rect.origin.y -= by
            rect.size.height += by
        } else if edge == .Left {
            rect.origin.x -= by
            rect.size.width += by
        } else if edge == .Bottom {
            rect.size.height += by
        } else if edge == .Right {
            rect.size.width += by
        }

        return rect
    }
}

extension CGRect {

    func rectByApplyingInsets(insets: UIEdgeInsets) -> CGRect {
        var rect = self
        rect.origin.x += insets.left
        rect.size.width -= insets.left + insets.right
        rect.origin.y += insets.top
        rect.size.height -= insets.top + insets.bottom
        return rect
    }
}

extension CGRect {

    var isDefined: Bool {
        if self.isEmpty || self.isInfinite || self.isNull {
            return false
        }
        return true
    }
}

extension CGRect {

    enum Aspect {
        case    Wide
        case    Tall
    }

    func slice(slice slice:Int, outOf:Int, aspect: Aspect) -> CGRect {
        var rect = self
        switch aspect {
            case    .Wide:  rect.size.height /= CGFloat(outOf)
                            rect.origin.y += rect.size.height * CGFloat(slice)
            case    .Tall:  rect.size.width /= CGFloat(outOf)
                            rect.origin.x += rect.size.width * CGFloat(slice)
        }
        return rect
    }
}

extension CGRect {

    enum Sizest {   /// yeah, play with English a bit
        case    Shortest
        case    Tallest
    }

    func squarest(sizest: Sizest) -> CGRect {
        var rect = self
        let min = rect.width < rect.height ? rect.width : rect.height
        let max = rect.width > rect.height ? rect.width : rect.height
        let dim = sizest == .Shortest ? min : max
        rect.size.width = dim
        rect.size.height = dim
        return rect
    }

    func square(side: CGFloat) -> CGRect {
        var rect = self
        rect.size.width = side
        rect.size.height = side
        return rect
    }
}

extension CGRect {

    func north() -> CGPoint {       return CGPoint(x:self.midX, y:self.minY)    }
    func northEast() -> CGPoint {   return CGPoint(x:self.maxX, y:self.minY)    }
    func east() -> CGPoint {        return CGPoint(x:self.maxX, y:self.midY)    }
    func southEast() -> CGPoint {   return CGPoint(x:self.maxX, y:self.maxY)    }
    func south() -> CGPoint {       return CGPoint(x:self.midX, y:self.maxY)    }
    func southWest() -> CGPoint {   return CGPoint(x:self.minX, y:self.maxY)    }
    func west() -> CGPoint {        return CGPoint(x:self.minX, y:self.midY)    }
    func northWest() -> CGPoint {   return CGPoint(x:self.minX, y:self.minY)    }
}

extension CGRect {

    var N:  CGPoint     {   return north()      }
    var NE: CGPoint     {   return northEast()  }
    var E:  CGPoint     {   return east()       }
    var SE: CGPoint     {   return southEast()  }
    var S:  CGPoint     {   return south()      }
    var SW: CGPoint     {   return southWest()  }
    var W:  CGPoint     {   return west()       }
    var NW: CGPoint     {   return northWest()  }

}

extension CGRect {

    var topLeft:CGPoint     {   return NW       }
    var topRight:CGPoint    {   return NE       }
    var bottomLeft:CGPoint  {   return SW       }
    var bottomRight:CGPoint {   return SE       }

}

extension CGRect {

    func centered(witdh: CGFloat, height: CGFloat) -> CGRect {
        /// workaround some Swift code gen bug that mistakes self.width &
        /// self.height with the width and height parameters ...

        var rect = CGRect.zero
        rect.size = CGSize(width: witdh, height: height)

        var orgn = self.center
        orgn.x -= rect.size.width / 2.0
        orgn.y -= rect.size.height / 2.0
        rect.origin = orgn

        return rect
    }

    func centered(side: CGFloat) -> CGRect {
        return self.centered(side, height: side)
    }

    func centeredPosition(position:CGPoint) -> CGRect {
        var rect = self

        rect.origin.x = position.x - rect.width / 2.0
        rect.origin.y = position.y - rect.height / 2.0

        return rect
    }

    func centeredXPosition(positionX:CGFloat) -> CGRect {
        var rect = self

        rect.origin.x = positionX - rect.width / 2.0

        return rect
    }
}

extension CGRect {
    func centerAttractor() -> CGRect {
        return self.squarest(.Shortest).centered(intoRect: self)
    }
}