
import CoreGraphics

/// A layout that diplays its background content behind its foreground content.
public struct BackgroundLayout<Background: Layout, Foreground: Layout>: Layout where Background.Content == Foreground.Content {
	public typealias Content = Background.Content
	
	public var background: Background
	public var foreground: Foreground
	
	public mutating func layout(in rect: CGRect) {
		background.layout(in: rect)
		foreground.layout(in: rect)
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		let backSize = background.sizeThatFits(size)
		let foreSize = foreground.sizeThatFits(size)
		let width = max(backSize.width, foreSize.width)
		let height = max(backSize.height, foreSize.height)
		
		return CGSize(width: width, height: height)
	}
	
	public var contents: [Content] {
		return background.contents + foreground.contents
	}
}

/**
In this extension we define a methods that allow us to easily chain layouts
together. For example, you can now take any `Layout` type and call
`withBackground(backgroundLayout)` to get the same layout but with a background.
This is a convenient alternative to using initializer syntax if you're composing multiple
layouts together.
*/
extension Layout {
	/// Returns a layout that shows `self` in front of `background`.
	public func withBackground<Background: Layout>(_ background: Background) -> BackgroundLayout<Background, Self> where Background.Content == Content {
		return BackgroundLayout(background: background, foreground: self)
	}
}
