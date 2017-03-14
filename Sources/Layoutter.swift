//
//  Layoutter.swift
//  Layoutter
//
//  Created by Farzad Sharbafian on 3/12/17.
//  Copyright © 2017 FarzadShbfn. All rights reserved.
//

import Foundation
import UIKit

protocol Layoutter {
	/// The type of the leaf content elements in this layout.
	associatedtype Content
	
	var layout: AnyLayout<Content> { get }
}


extension Layoutter where Self: Layout {
	
	func layout(in rect: CGRect) {
		layout.layout(in: rect)
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		return layout.sizeThatFits(size)
	}
}


extension Layoutter where Self: UIView {
	
	func layoutSubviews() {
		layout(in: self.bounds)
	}
}
