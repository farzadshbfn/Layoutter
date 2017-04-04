//
//  Layoutter.swift
//  Layoutter
//
//  Created by Farzad Sharbafian on 3/12/17.
//  Copyright © 2017 FarzadShbfn. All rights reserved.
//

import Foundation
import UIKit

public protocol Layoutter {
	/// The type of the leaf content elements in this layout.
	associatedtype Content
	
	var layout: AnyLayout<Content> { get }
}


extension Layoutter where Self: Layout {
	
	public func layout(in rect: CGRect) {
		layout.layout(in: rect)
	}
	
	public func sizeThatFits(_ size: CGSize) -> CGSize {
		return layout.sizeThatFits(size)
	}
}


extension Layoutter where Self: UIView {
	
	public func layoutSubviews() {
		layout(in: self.bounds)
	}
}
