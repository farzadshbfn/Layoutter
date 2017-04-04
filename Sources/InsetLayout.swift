
import UIKit

/// An layout that insets its child content.
public struct InsetLayout<Child: Layout>: Layout {
	public typealias Content = Child.Content
	
	public var child: Child
	
	public var insets: UIEdgeInsets
	
	/*
	This initializer is private because the canonical way to inset a layout
	is by using the `withInsets(...)` method family defined below.
	*/
	fileprivate init(child: Child, insets: UIEdgeInsets) {
		self.child = child
		self.insets = insets
	}
	
	public mutating func layout(in rect: CGRect) {
		let rect = UIEdgeInsetsInsetRect(rect, insets)
		
		child.layout(in: rect)
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		var dstSize = size
		dstSize.width -= insets.left + insets.right
		dstSize.height -= insets.top + insets.bottom
		
		let childSize = child.sizeThatFits(dstSize)
		
		let width = insets.left + childSize.width + insets.right
		let height = insets.top + childSize.height + insets.bottom
		
		return CGSize(width: width, height: height)
	}
	
	public var contents: [Content] {
		return child.contents
	}
}

/**
In this extension we define methods that allow us to easily chain layouts
together. For example, you can now take any `Layout` type and call
`withInsets(top: 5)` to get the same layout but insetted by 5 points. This is
a convenient alternative to using initializer syntax if you're composing multiple
layouts together.
*/
extension Layout {
	/// Makes an inset layout.
	public func withInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> InsetLayout<Self> {
		let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
		
		return withInsets(insets)
	}
	
	/// Makes an inset layout.
	public func withInsets(all insets: CGFloat) -> InsetLayout<Self> {
		return withInsets(top: insets, left: insets, bottom: insets, right: insets)
	}
	
	/// Makes an inset layout.
	public func withInsets(_ insets: UIEdgeInsets) -> InsetLayout<Self> {
		return InsetLayout(child: self, insets: insets)
	}
}

// MARK: - In this extension we define methods that allow us to easily chain insetLayouts
extension InsetLayout {
	/// Makes an inset layout.
	public func withInsets(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) -> InsetLayout<Child> {
		let insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
		
		return withInsets(insets)
	}
	
	/// Makes an inset layout.
	public func withInsets(all insets: CGFloat) -> InsetLayout<Child> {
		return withInsets(top: insets, left: insets, bottom: insets, right: insets)
	}
	
	/// Makes an inset layout.
	public func withInsets(_ insets: UIEdgeInsets) -> InsetLayout<Child> {
		var dstInsets = self.insets
		dstInsets.top += insets.top
		dstInsets.left += insets.left
		dstInsets.bottom += insets.bottom
		dstInsets.right += insets.right
		
		return InsetLayout(child: child, insets: dstInsets)
	}
}
