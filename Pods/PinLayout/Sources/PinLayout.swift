//  Copyright (c) 2017 Luc Dion
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

#if os(iOS) || os(tvOS)
import UIKit

// MARK: - PinLayout UIView's extension
public extension UIView {
    public var pin: PinLayout {
        return PinLayoutImpl(view: self)
    }

    public var anchor: AnchorList {
        return AnchorListImpl(view: self)
    }

    public var edge: EdgeList {
        return EdgeListImpl(view: self)
    }
}

/*
 UIView's anchors point
 ======================

         topLeft      topCenter       topRight
            o-------------o--------------o
            |                            |
            |                            |
            |                            |
            |                            |
            |                            |
            |           center           |
 centerLeft o             o              o centerRight
            |                            |
            |                            |
            |                            |
            |                            |
            |                            |
            |                            |
            o-------------o--------------o
       bottomLeft    bottomCenter     bottomLeft

 */

/// UIViews's anchor definition
@objc public protocol Anchor {
}

/// UIViews's list of anchors.
@objc public protocol AnchorList {
    var topLeft: Anchor { get }
    var topCenter: Anchor { get }
    var topRight: Anchor { get }
    var centerLeft: Anchor { get }
    var center: Anchor { get }
    var centerRight: Anchor { get }
    var bottomLeft: Anchor { get }
    var bottomCenter: Anchor { get }
    var bottomRight: Anchor { get }

    // RTL support
    var topStart: Anchor { get }
    var topEnd: Anchor { get }
    var centerStart: Anchor { get }
    var centerEnd: Anchor { get }
    var bottomStart: Anchor { get }
    var bottomEnd: Anchor { get }
}

/*
 UIView's Edges
 ======================
                   top
          +-----------------+
          |                 |
          |                 |
          |     hCenter     |
     left |        +        | right
          |     vCenter     |
          |                 |
          |                 |
          +-----------------+
                  bottom
*/

/// UIViews's list of edges
@objc public protocol EdgeList {
    var top: VerticalEdge { get }
    var vCenter: VerticalEdge { get }
    var bottom: VerticalEdge { get }
    var left: HorizontalEdge { get }
    var hCenter: HorizontalEdge { get }
    var right: HorizontalEdge { get }

    // RTL support
    var start: HorizontalEdge { get }
    var end: HorizontalEdge { get }
}

/// PinLayout interface
public protocol PinLayout {
    //
    // MARK: Layout using distances from superview’s edges
    //
    @discardableResult func top() -> PinLayout
    @discardableResult func top(_ value: CGFloat) -> PinLayout
    @discardableResult func top(_ percent: Percent) -> PinLayout
    
    @discardableResult func left() -> PinLayout
    @discardableResult func left(_ value: CGFloat) -> PinLayout
    @discardableResult func left(_ percent: Percent) -> PinLayout
    
    @discardableResult func bottom() -> PinLayout
    @discardableResult func bottom(_ value: CGFloat) -> PinLayout
    @discardableResult func bottom(_ percent: Percent) -> PinLayout
    
    @discardableResult func right() -> PinLayout
    @discardableResult func right(_ value: CGFloat) -> PinLayout
    @discardableResult func right(_ percent: Percent) -> PinLayout
    
    @discardableResult func hCenter() -> PinLayout
    @discardableResult func hCenter(_ value: CGFloat) -> PinLayout
    @discardableResult func hCenter(_ percent: Percent) -> PinLayout
    
    @discardableResult func vCenter() -> PinLayout
    @discardableResult func vCenter(_ value: CGFloat) -> PinLayout
    @discardableResult func vCenter(_ percent: Percent) -> PinLayout

    // RTL support
    @discardableResult func start() -> PinLayout
    @discardableResult func start(_ value: CGFloat) -> PinLayout
    @discardableResult func start(_ percent: Percent) -> PinLayout
    @discardableResult func end() -> PinLayout
    @discardableResult func end(_ value: CGFloat) -> PinLayout
    @discardableResult func end(_ percent: Percent) -> PinLayout
    
    // Pin multiple edges at once.
    /**
     Pin all edges on its superview's corresponding edges (top, bottom, left, right).
     
     Similar to calling `view.top().bottom().left().right()`
     */
    @discardableResult func all() -> PinLayout
    /**
     Pin the left and right edges on its superview's corresponding edges.
     
     Similar to calling `view.left().right()`.
     */
    @discardableResult func horizontally() -> PinLayout
    /**
     Pin the **top and bottom edges** on its superview's corresponding edges.
     
     Similar to calling `view.top().bottom()`.
     */
    @discardableResult func vertically() -> PinLayout
    
    //
    // MARK: Layout using edges
    //
    @discardableResult func top(to edge: VerticalEdge) -> PinLayout
    @discardableResult func vCenter(to edge: VerticalEdge) -> PinLayout
    @discardableResult func bottom(to edge: VerticalEdge) -> PinLayout
    @discardableResult func left(to edge: HorizontalEdge) -> PinLayout
    @discardableResult func hCenter(to edge: HorizontalEdge) -> PinLayout
    @discardableResult func right(to edge: HorizontalEdge) -> PinLayout
    // RTL support
    @discardableResult func start(to edge: HorizontalEdge) -> PinLayout
    @discardableResult func end(to edge: HorizontalEdge) -> PinLayout

    //
    // MARK: Layout using anchors
    //
    @discardableResult func topLeft(to anchor: Anchor) -> PinLayout
    @discardableResult func topLeft() -> PinLayout
    @discardableResult func topStart(to anchor: Anchor) -> PinLayout
    @discardableResult func topStart() -> PinLayout

    @discardableResult func topCenter(to anchor: Anchor) -> PinLayout
    @discardableResult func topCenter() -> PinLayout

    @discardableResult func topRight(to anchor: Anchor) -> PinLayout
    @discardableResult func topRight() -> PinLayout
    @discardableResult func topEnd(to anchor: Anchor) -> PinLayout
    @discardableResult func topEnd() -> PinLayout

    @discardableResult func centerLeft(to anchor: Anchor) -> PinLayout
    @discardableResult func centerLeft() -> PinLayout
    @discardableResult func centerStart(to anchor: Anchor) -> PinLayout
    @discardableResult func centerStart() -> PinLayout

    @discardableResult func center(to anchor: Anchor) -> PinLayout
    @discardableResult func center() -> PinLayout

    @discardableResult func centerRight(to anchor: Anchor) -> PinLayout
    @discardableResult func centerRight() -> PinLayout
    @discardableResult func centerEnd(to anchor: Anchor) -> PinLayout
    @discardableResult func centerEnd() -> PinLayout

    @discardableResult func bottomLeft(to anchor: Anchor) -> PinLayout
    @discardableResult func bottomLeft() -> PinLayout
    @discardableResult func bottomStart(to anchor: Anchor) -> PinLayout
    @discardableResult func bottomStart() -> PinLayout

    @discardableResult func bottomCenter(to anchor: Anchor) -> PinLayout
    @discardableResult func bottomCenter() -> PinLayout

    @discardableResult func bottomRight(to anchor: Anchor) -> PinLayout
    @discardableResult func bottomRight() -> PinLayout
    @discardableResult func bottomEnd(to anchor: Anchor) -> PinLayout
    @discardableResult func bottomEnd() -> PinLayout

    //
    // MARK: Layout using relative positioning
    //
    @discardableResult func above(of: UIView) -> PinLayout
    @discardableResult func above(of: [UIView]) -> PinLayout
    @discardableResult func above(of: UIView, aligned: HorizontalAlign) -> PinLayout
    @discardableResult func above(of: [UIView], aligned: HorizontalAlign) -> PinLayout
    
    @discardableResult func below(of: UIView) -> PinLayout
    @discardableResult func below(of: [UIView]) -> PinLayout
    @discardableResult func below(of: UIView, aligned: HorizontalAlign) -> PinLayout
    @discardableResult func below(of: [UIView], aligned: HorizontalAlign) -> PinLayout
    
    @discardableResult func left(of: UIView) -> PinLayout
    @discardableResult func left(of: [UIView]) -> PinLayout
    @discardableResult func left(of: UIView, aligned: VerticalAlign) -> PinLayout
    @discardableResult func left(of: [UIView], aligned: VerticalAlign) -> PinLayout
    
    @discardableResult func right(of: UIView) -> PinLayout
    @discardableResult func right(of: [UIView]) -> PinLayout
    @discardableResult func right(of: UIView, aligned: VerticalAlign) -> PinLayout
    @discardableResult func right(of: [UIView], aligned: VerticalAlign) -> PinLayout

    // RTL support
    @discardableResult func before(of: UIView) -> PinLayout
    @discardableResult func before(of: [UIView]) -> PinLayout
    @discardableResult func before(of: UIView, aligned: VerticalAlign) -> PinLayout
    @discardableResult func before(of: [UIView], aligned: VerticalAlign) -> PinLayout
    @discardableResult func after(of: UIView) -> PinLayout
    @discardableResult func after(of: [UIView]) -> PinLayout
    @discardableResult func after(of: UIView, aligned: VerticalAlign) -> PinLayout
    @discardableResult func after(of: [UIView], aligned: VerticalAlign) -> PinLayout

    //
    // MARK: justify / align
    //
    @discardableResult func justify(_: HorizontalAlign) -> PinLayout
    @discardableResult func align(_: VerticalAlign) -> PinLayout
    
    //
    // MARK: Width, height and size
    //
    @discardableResult func width(_ width: CGFloat) -> PinLayout
    @discardableResult func width(_ percent: Percent) -> PinLayout
    @discardableResult func width(of view: UIView) -> PinLayout
    @discardableResult func minWidth(_ width: CGFloat) -> PinLayout
    @discardableResult func minWidth(_ percent: Percent) -> PinLayout
    @discardableResult func maxWidth(_ width: CGFloat) -> PinLayout
    @discardableResult func maxWidth(_ percent: Percent) -> PinLayout
    
    @discardableResult func height(_ height: CGFloat) -> PinLayout
    @discardableResult func height(_ percent: Percent) -> PinLayout
    @discardableResult func height(of view: UIView) -> PinLayout
    @discardableResult func minHeight(_ height: CGFloat) -> PinLayout
    @discardableResult func minHeight(_ percent: Percent) -> PinLayout
    @discardableResult func maxHeight(_ height: CGFloat) -> PinLayout
    @discardableResult func maxHeight(_ percent: Percent) -> PinLayout
    
    @discardableResult func size(_ size: CGSize) -> PinLayout
    @discardableResult func size(_ sideLength: CGFloat) -> PinLayout
    @discardableResult func size(_ percent: Percent) -> PinLayout
    @discardableResult func size(of view: UIView) -> PinLayout
    
    /**
     Set the view aspect ratio.
     
     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.

     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * An aspect ratio of 2 means the width is twice the size of the height.
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight) 
     dimensions of an item.
     */
    @discardableResult func aspectRatio(_ ratio: CGFloat) -> PinLayout
    /**
     Set the view aspect ratio using another UIView's aspect ratio. 
     
     AspectRatio is applied only if a single dimension (either width or height) can be determined,
     in that case the aspect ratio will be used to compute the other dimension.
     
     * AspectRatio is defined as the ratio between the width and the height (width / height).
     * AspectRatio respects the min (minWidth/minHeight) and the max (maxWidth/maxHeight)
     dimensions of an item.
     */
    @discardableResult func aspectRatio(of view: UIView) -> PinLayout
    /**
     If the layouted view is an UIImageView, this method will set the aspectRatio using
     the UIImageView's image dimension.
     
     For other types of views, this method as no impact.
     */
    @discardableResult func aspectRatio() -> PinLayout
    
    @available(*, deprecated, message: "You should now use fitSize() instead.")
    @discardableResult func sizeToFit() -> PinLayout
    @discardableResult func fitSize() -> PinLayout

    //
    // MARK: Margins
    //
    
    /**
     Set the top margin.
     */
    @discardableResult func marginTop(_ value: CGFloat) -> PinLayout
    
    /**
     Set the left margin.
     */
    @discardableResult func marginLeft(_ value: CGFloat) -> PinLayout
    
    /**
     Set the bottom margin.
     */
    @discardableResult func marginBottom(_ value: CGFloat) -> PinLayout
    
    /**
     Set the right margin.
     */
    @discardableResult func marginRight(_ value: CGFloat) -> PinLayout
    
    // RTL support
    /**
     Set the start margin.
     
     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, start margin specify the **left** margin.
     * In RTL direction, start margin specify the **right** margin.
     */
    @discardableResult func marginStart(_ value: CGFloat) -> PinLayout
    
    /**
     Set the end margin.
     
     Depends on the value of `Pin.layoutDirection(...)`:
     * In LTR direction, end margin specify the **right** margin.
     * In RTL direction, end margin specify the **left** margin.
     */
    @discardableResult func marginEnd(_ value: CGFloat) -> PinLayout
    
    /**
     Set the left, right, start and end margins to the specified value.
     */
    @discardableResult func marginHorizontal(_ value: CGFloat) -> PinLayout
    
    /**
     Set the top and bottom margins to the specified value.
     */
    @discardableResult func marginVertical(_ value: CGFloat) -> PinLayout

    /**
     Set all margins using UIEdgeInsets. 
     This method is particularly useful to set all margins using iOS 11 `UIView.safeAreaInsets`.
     */
    @discardableResult func margin(_ insets: UIEdgeInsets) -> PinLayout
    
    /**
     Set margins using NSDirectionalEdgeInsets.
     This method is particularly to set all margins using iOS 11 `UIView.directionalLayoutMargins`.
     
     Available only on iOS 11 and higher.
     */
    @available(tvOS 11.0, iOS 11.0, *)
    @discardableResult func margin(_ directionalInsets: NSDirectionalEdgeInsets) -> PinLayout

    /**
     Set all margins to the specified value.
     */
    @discardableResult func margin(_ value: CGFloat) -> PinLayout
    
    /**
     Set individually vertical margins (top, bottom) and horizontal margins (left, right, start, end).
     */
    @discardableResult func margin(_ vertical: CGFloat, _ horizontal: CGFloat) -> PinLayout
    
    /**
     Set individually top, horizontal margins and bottom margin.
     */
    @discardableResult func margin(_ top: CGFloat, _ horizontal: CGFloat, _ bottom: CGFloat) -> PinLayout
    
    /**
     Set individually top, left, bottom and right margins.
     */
    @discardableResult func margin(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> PinLayout

    /// Normally if only either left or right has been specified, PinLayout will MOVE the view to apply left or right margins.
    /// This is also true even if the width has been set.
    /// Calling pinEdges() will force PinLayout to pin the four edges and then apply left and/or right margins, and this without
    /// moving the view.
    ///
    /// - Returns: PinLayout
    @discardableResult func pinEdges() -> PinLayout
}

/// Horizontal alignment used with relative positionning methods: above(of relativeView:, aligned:), below(of relativeView:, aligned:)
///
/// - left: left aligned
/// - center: center aligned
/// - right: right aligned
@objc public enum HorizontalAlign: Int {
    case left
    case center
    case right
    
    // RTL support
    case start
    case end
}

/// Vertical alignment used with relative positionning methods: left(of relativeView:, aligned:), right(of relativeView:, aligned:)
///
/// - top: top aligned
/// - center: center aligned
/// - bottom: bottom aligned
@objc public enum VerticalAlign: Int {
    case top
    case center
    case bottom
}

/// UIView's horizontal edges (left/right) definition
@objc public protocol HorizontalEdge {
}

/// UIView's vertical edges (top/bottom) definition
@objc public protocol VerticalEdge {
}
        
#endif
