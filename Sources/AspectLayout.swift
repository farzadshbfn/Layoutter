
import Foundation

/**
*  Main usage of this method is for sizeThatFits
*/
struct AspectLayout<Child: Layout>: Layout {
	typealias Content = Child.Content
	
	var child: Child
	var aspectRatio: CGSize
	
	init (child: Child, aspectRatio: CGSize) {
		self.child = child
		self.aspectRatio = aspectRatio
	}
	
	mutating func layout(in rect: CGRect) {
		child.layout(in: rect)
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		
		let aspectHeight = size.width * aspectRatio.height / aspectRatio.width
		let aspectWidth = size.height * aspectRatio.width / aspectRatio.height
		
		if aspectHeight < size.height {
			return CGSize(width: size.width, height: aspectHeight)
		}
		return CGSize(width: aspectWidth, height: size.height)
	}
	
	var contents: [Content] {
		return child.contents
	}
}


extension Layout {
	/// Makes an Aspect Layout
	func withAspect(_ aspectRatio: CGSize) -> AspectLayout<Self> {
		return AspectLayout(child: self, aspectRatio: aspectRatio)
	}
}
