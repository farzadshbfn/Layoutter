
import Foundation


public struct EmptyViewLayout: Layout {
	public typealias Content = UIView
	
	public func layout(in rect: CGRect) {
		// Does nothing
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		return .zero
	}
	
	public var contents: [UIView] {
		return []
	}
}
