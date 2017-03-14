
import Foundation

struct SizeLayout<Child: Layout>: Layout {
	typealias Content = Child.Content
	
	var child: Child
	var size: CGSize
	
	mutating func layout(in rect: CGRect) {
		child.layout(in: rect)
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		var checkSize = size
		checkSize.width = self.size.width.isNaN ? checkSize.width : self.size.width
		checkSize.height = self.size.height.isNaN ? checkSize.height : self.size.height
		
		var childSize = child.sizeThatFits(checkSize)
		
		childSize.width = self.size.width.isNaN ? childSize.width : self.size.width
		childSize.height = self.size.height.isNaN ? childSize.height : self.size.height
		return childSize
	}
	
	var contents: [Content] {
		return child.contents
	}
}


extension Layout {
	func withSize(width: CGFloat = CGFloat.nan, height: CGFloat = CGFloat.nan) -> SizeLayout<Self> {
		return self.withSize(CGSize(width: width, height: height))
	}
	
	func withSize(_ size: CGSize) -> SizeLayout<Self> {
		return SizeLayout(child: self, size: CGSize(width: size.width, height: size.height))
	}
}

extension SizeLayout {
	func withSize(width: CGFloat = CGFloat.nan, height: CGFloat = CGFloat.nan) -> SizeLayout<Child> {
		return withSize(CGSize(width: width, height: height))
	}
	
	func withSize(_ size: CGSize) -> SizeLayout<Child> {
		var dstSize = self.size
		dstSize.width = size.width.isNaN ? dstSize.width : size.width
		dstSize.height = size.height.isNaN ? dstSize.height : size.height
		return SizeLayout(child: child, size: dstSize)
	}
}
