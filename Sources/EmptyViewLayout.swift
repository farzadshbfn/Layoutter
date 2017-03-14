
import Foundation


struct EmptyViewLayout: Layout {
	typealias Content = UIView
	
	func layout(in rect: CGRect) {
		// Does nothing
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		return .zero
	}
	
	var contents: [UIView] {
		return []
	}
}
