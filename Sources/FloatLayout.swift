
import Foundation


// A layout that decorates current layout on margins or corners or center
struct FloatLayout<Child: Layout>: Layout {
	typealias Content = Child.Content
	
	var child: Child
	
	var verticalAlignment: UIControlContentVerticalAlignment
	var horizontalAlignment: UIControlContentHorizontalAlignment
	
	init(child: Child,
	     verticalAlignment: UIControlContentVerticalAlignment = .center,
	     horizontalAlignment: UIControlContentHorizontalAlignment = .center) {
		
		self.child = child
		self.verticalAlignment = verticalAlignment
		self.horizontalAlignment = horizontalAlignment
	}
	
	mutating func layout(in rect: CGRect) {
		let childRect = self.childRect(in: rect)
		
		child.layout(in: childRect)
	}
	
	fileprivate func childRect(in rect: CGRect) -> CGRect {
		let childSize = child.sizeThatFits(rect.size)
		
		var x = rect.midX - childSize.width / 2
		var y = rect.midY - childSize.height / 2
		var width = childSize.width
		var height = childSize.height
		
		switch horizontalAlignment {
		case .fill: width = rect.width; fallthrough
		case .left: x = rect.minX
		case .right: x = rect.maxX - width
		case .center: break
		}
		
		switch verticalAlignment {
		case .fill: height = rect.height; fallthrough
		case .top: y = rect.minY
		case .bottom: y = rect.maxY - height
		case .center: break
		}
		
		return CGRect(x: x, y: y, width: width, height: height)
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		return child.sizeThatFits(size)
	}
	
	var contents: [Content] {
		return child.contents
	}
}


extension Layout {
	func withFloat(verticalAlignment: UIControlContentVerticalAlignment = .center,
	               horizontalAlignment: UIControlContentHorizontalAlignment = .center) -> FloatLayout<Self> {
		return FloatLayout(child: self, verticalAlignment: verticalAlignment, horizontalAlignment: horizontalAlignment)
	}
}
