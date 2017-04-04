
import CoreGraphics

/// A layout that renders content on top of each other in the z dimension.
public struct ZStackLayout<Child: Layout>: Layout {
	public typealias Content = Child.Content
	
	public var children: [Child]
	
	public mutating func layout(in rect: CGRect) {
		for index in children.indices {
			/*
			The same rect is used for each layout——the important part for the
			`ZStackLayout` is that it returns its child's contents in the correct
			order.
			*/
			children[index].layout(in: rect)
		}
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		return children.reduce(CGSize.zero) {
			let childSize = $1.sizeThatFits(size)
			
			let width = max($0.width, childSize.width)
			let height = max($0.height, childSize.height)
			
			return CGSize(width: width, height: height)
		}
	}
	
	public var contents: [Content] {
		return children.flatMap { $0.contents }
	}
	
}
