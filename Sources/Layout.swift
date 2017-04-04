/*

Abstract:
Defines the `Layout` protocol.
*/

import CoreGraphics

/// A type that can layout itself and its contents.
public protocol Layout {
	/// Lay out this layout and all of its contained layouts within `rect`.
	mutating func layout(in rect: CGRect)
	
	/// Returns the size needed to lay out this layout with no loss.
	func sizeThatFits(_ size: CGSize) -> CGSize
	
	/// The type of the leaf content elements in this layout.
	associatedtype Content
	
	/// Return all of the leaf content elements contained in this layout and its descendants.
	var contents: [Content] { get }
}


/// Wraps a layout in SpecificLayout to generalize.
/// Usage: Layout can not be stored as variable because of associatedtype. use this struct instead.
public struct AnyLayout<C>: Layout {
	var _layout: (_ in: CGRect)-> ()
	var _sizeThatFits: (CGSize) -> CGSize
	var _contents: () -> [C]
	
	/// Changes Layouts, but can not fetch info from Layout itself.
	/// like: current frame or etc.
	init <L: Layout> (_ _selfie: L) where L.Content == C {
		var selfie = _selfie
		_layout = { selfie.layout(in: $0) }
		_sizeThatFits = { selfie.sizeThatFits($0) }
		_contents = { selfie.contents }
	}
	
	public func layout(in rect: CGRect) {
		_layout(rect)
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		return _sizeThatFits(size)
	}
	
	public var contents: [C] {
		return _contents()
	}
}
