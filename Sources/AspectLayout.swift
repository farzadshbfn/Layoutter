
import Foundation

/**
*  Main usage of this method is for sizeThatFits
*/
public struct AspectLayout<Child: Layout>: Layout {
	public typealias Content = Child.Content
	
	public var child: Child
	public var aspectRatio: CGSize
	
	public init (child: Child, aspectRatio: CGSize) {
		self.child = child
		self.aspectRatio = aspectRatio
	}
	
	public mutating func layout(in rect: CGRect) {
		child.layout(in: rect)
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		
		let aspectHeight = size.width * aspectRatio.height / aspectRatio.width
		let aspectWidth = size.height * aspectRatio.width / aspectRatio.height
		
		if aspectHeight < size.height {
			return CGSize(width: size.width, height: aspectHeight)
		}
		return CGSize(width: aspectWidth, height: size.height)
	}
	
	public var contents: [Content] {
		return child.contents
	}
}


extension Layout {
	/// Makes an Aspect Layout
	public func withAspect(_ aspectRatio: CGSize) -> AspectLayout<Self> {
		return AspectLayout(child: self, aspectRatio: aspectRatio)
	}
}
