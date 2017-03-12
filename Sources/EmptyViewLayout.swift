//
//  EmptyViewLayout.swift
//  filimo
//
//  Created by Farzad Sharbafian on 8/15/16.
//  Copyright © 2016 Sabaidea. All rights reserved.
//

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
