
import Foundation

// A layout that decorates two layouts on top and bottom
struct VerticalDecoratingLayout<Decoration: Layout, ChildContent: Layout>: Layout where ChildContent.Content == Decoration.Content {
	
	typealias Content = ChildContent.Content
	
	var decoration: InsetLayout<Decoration>
	var content: InsetLayout<ChildContent>
	
	var alignment: UIControlContentVerticalAlignment
	
	init(decoration: Decoration,
	     content: ChildContent,
	     spacing: CGFloat = 8.0,
	     alignment: UIControlContentVerticalAlignment = .center) {
		
		self.decoration = decoration.withInsets(all: spacing).withInsets(bottom: -spacing / 2)
		self.content = content.withInsets(all: spacing).withInsets(top: -spacing / 2)
		self.alignment = alignment
	}
	
	mutating func layout(in rect: CGRect) {
		let contentRect = self.contentRect(in: rect)
		let decorationRect = self.decorationRect(in: rect)
		
		content.layout(in: contentRect)
		decoration.layout(in: decorationRect)
	}
	
	func decorationRect(in rect: CGRect) -> CGRect {
		var dstRect = rect
		
		switch alignment {
		case .top:
			let decorationSize = decoration.sizeThatFits(rect.size)
			dstRect.size.height = decorationSize.height
			
		case .bottom:
			let contentSize = content.sizeThatFits(rect.size)
			dstRect.size.height = rect.height - contentSize.height
			
		case .fill, .center: // TODO: Implement Center later
			dstRect.size.height = rect.height / 2
		}
		
		return dstRect
	}
	
	func contentRect(in rect: CGRect) -> CGRect {
		var dstRect = rect
		
		switch alignment {
		case .bottom:
			let contentSize = content.sizeThatFits(rect.size)
			dstRect.origin.y = rect.maxY - contentSize.height
			dstRect.size.height = contentSize.height
			
		case .top:
			let decorationSize = decoration.sizeThatFits(rect.size)
			dstRect.origin.y = rect.minY + decorationSize.height
			dstRect.size.height = rect.height - decorationSize.height
			
		case .fill, .center:
			dstRect.origin.y = rect.midY
			dstRect.size.height = rect.height / 2
		}
		
		return dstRect
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		let contentSize: CGSize!
		let decorationSize: CGSize!
		
		switch alignment {
		case .bottom:
			contentSize = content.sizeThatFits(size)
			let leftSize = CGSize(width: size.width, height: size.height - contentSize.height)
			decorationSize = decoration.sizeThatFits(leftSize)
			
		case .top:
			decorationSize = decoration.sizeThatFits(size)
			let leftSize = CGSize(width: size.width, height: size.height - decorationSize.height)
			contentSize = content.sizeThatFits(leftSize)
			
		case .fill, .center:
			let halfSize = CGSize(width: size.width, height: size.height / 2)
			contentSize = content.sizeThatFits(halfSize)
			decorationSize = decoration.sizeThatFits(halfSize)
		}
		
		let width = max(contentSize.width, decorationSize.width)
		let height = contentSize.height + decorationSize.height
		
		return CGSize(width: width, height: height)
	}
	
	var contents: [Content] {
		return decoration.contents + content.contents
	}
}
