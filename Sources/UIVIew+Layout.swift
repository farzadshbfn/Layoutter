/*
Copyright (C) 2016 Apple Inc. All Rights Reserved.
See LICENSE.txt for this sample’s licensing information

Abstract:
Uses retroactive modeling to make `UIView` a `Layout`.
*/

import UIKit

extension UIView: Layout {
	public typealias Content = UIView
	
	public func layout(in rect: CGRect) {
		self.frame = rect
	}
	
	public var contents: [Content] {
		return [self]
	}
}
