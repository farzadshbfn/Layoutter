
import Foundation

// A layout that decorates two layouts on left and right
public struct HorizontalDecoratingLayout<Decoration: Layout, ChildContent: Layout>: Layout where ChildContent.Content == Decoration.Content {
	
	public typealias Content = ChildContent.Content
	public typealias Alignment = (left: Bool, right: Bool)
	
	public var decoration: InsetLayout<Decoration>
	public var content: InsetLayout<ChildContent>
	
	public var alignment: UIControlContentHorizontalAlignment
	
	public init(decoration: Decoration,
	     content: ChildContent,
	     spacing: CGFloat = 8.0,
	     alignment: UIControlContentHorizontalAlignment = .center) {
		
		self.decoration = decoration.withInsets(all: spacing).withInsets(right: -spacing / 2)
		self.content = content.withInsets(all: spacing).withInsets(left: -spacing / 2)
		self.alignment = alignment
	}
	
	public mutating func layout(in rect: CGRect) {
		let contentRect = self.contentRect(in: rect)
		let decorationRect = self.decorationRect(in: rect)
		
		content.layout(in: contentRect)
		decoration.layout(in: decorationRect)
	}
	
	public func decorationRect(in rect: CGRect) -> CGRect {
		var dstRect = rect
		
		switch alignment {
		case .left:
			let decorationSize = decoration.sizeThatFits(rect.size)
			dstRect.size.width = decorationSize.width
			
		case .right:
			let contentSize = content.sizeThatFits(rect.size)
			dstRect.size.width = rect.width - contentSize.width
			
		case .fill, .center: // TODO: implement center later
			dstRect.size.width = rect.width / 2
		}
		
		return dstRect
	}
	
	public func contentRect(in rect: CGRect) -> CGRect {
		var dstRect = rect
		
		switch alignment {
		case .right:
			let contentSize = content.sizeThatFits(rect.size)
			dstRect.origin.x = rect.maxX - contentSize.width
			dstRect.size.width = contentSize.width
			
		case .left:
			let decorationSize = decoration.sizeThatFits(rect.size)
			dstRect.origin.x = rect.minX + decorationSize.width
			dstRect.size.width = rect.width - decorationSize.width
			
		case .fill, .center:
			dstRect.origin.x = rect.midX
			dstRect.size.width = rect.width / 2
		}
		
		return dstRect
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		let contentSize: CGSize!
		let decorationSize: CGSize!
		
		switch alignment {
		case .right:
			contentSize = content.sizeThatFits(size)
			let leftSize = CGSize(width: size.width - contentSize.width, height: size.height)
			decorationSize = decoration.sizeThatFits(leftSize)
			
		case .left:
			decorationSize = decoration.sizeThatFits(size)
			let leftSize = CGSize(width: size.width - decorationSize.width, height: size.height)
			contentSize = content.sizeThatFits(leftSize)
			
		case .fill, .center:
			let halfSize = CGSize(width: size.width / 2, height: size.height)
			
			contentSize = content.sizeThatFits(halfSize)
			decorationSize = decoration.sizeThatFits(halfSize)
			
		}
		
		let width = contentSize.width + decorationSize.width
		let height = max(contentSize.height, decorationSize.height)
		
		return CGSize(width: width, height: height)
	}
	
	public var contents: [Content] {
		return decoration.contents + content.contents
	}
}
