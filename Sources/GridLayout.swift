//
//  GridLayout.swift
//  filimo
//
//  Created by Farzad Sharbafian on 7/18/16.
//  Copyright © 2016 Sabaidea. All rights reserved.
//

import Foundation

enum GridLayoutDirection {
	case vertical(UIControlContentHorizontalAlignment)
	case horizontal(UIControlContentVerticalAlignment)
	
	/**
 *  UIControlContent(Horizontal|Vertical)Alignment
	
	- Fill -> Will use hard spacing and increase item sizes
	- Center -> Will use hard itme sizes and increase spacing
	- Top/Bottom|Left/Right : Will use hard spacing and will allign items
 */
}

private let errorThreshold: CGFloat = 0.000001

struct GridLayout<Child: Layout>: Layout {
	typealias Content = Child.Content
	
	typealias Cut = (childIndex: Int, size: CGSize)
	typealias VerticalCut = (row: [Cut], height: CGFloat)
	typealias HorizontalCut = (column: [Cut], width: CGFloat)
	
	var children: [Child]
	var direction: GridLayoutDirection
	var itemSpacing: CGFloat
	var lineSpacing: CGFloat
	// reverses items in a row/column
	var reverseSection: Bool
	// .Vertical: fills from bottom, .Horizontal: Fills from right
	var reverseFill: Bool
	
	init (children: [Child],
	      direction: GridLayoutDirection,
	      itemSpacing: CGFloat,
	      lineSpacing: CGFloat,
	      reverseSection: Bool = false,
	      reverseFill: Bool = false) {
		self.children = children
		self.direction = direction
		self.itemSpacing = itemSpacing
		self.lineSpacing = lineSpacing
		self.reverseSection = reverseSection
		self.reverseFill = reverseFill
	}
	
	mutating func layout(in rect: CGRect) {
		switch direction {
		case let .vertical(horizontalAlignment): layoutVertical(horizontalAlignment, in: rect)
		case let .horizontal(verticalAlignment): layoutHorizontal(verticalAlignment, in: rect)
		}
	}
	
	
	// MARK: Vertical
	
	fileprivate func cutRow(in size: CGSize) -> ([VerticalCut], CGSize) {
		var cuts: [VerticalCut] = []
		var row: [Cut] = []
		var height: CGFloat = 0.0
		var totalHeight: CGFloat = 0.0
		var width: CGFloat = -itemSpacing
		var maxWidth: CGFloat = 0.0
		
		for index in children.indices {
			let sizeLeft = CGSize(width: size.width - width, height: size.height)
			let childSize = children[index].sizeThatFits(sizeLeft)
			
			if width + itemSpacing + childSize.width > size.width + errorThreshold {
				if row.count > 0 { cuts.append((row, height)) }
				row.removeAll()
				totalHeight += height
				height = 0.0
				width = -itemSpacing
			}
			row.append((index, childSize))
			height = max(height, childSize.height)
			width += itemSpacing + childSize.width
			
			maxWidth = max(maxWidth, width)
		}
		
		if row.count > 0 { cuts.append((row, height)) }
		totalHeight += CGFloat(cuts.count - 1) * lineSpacing + height
		return (cuts, CGSize(width: maxWidth, height: totalHeight))
	}
	
	fileprivate mutating func layout(_ cuts: [Cut], alignment: UIControlContentHorizontalAlignment, in rect: CGRect) {
		let itemsWidth = cuts.reduce(CGFloat(0)) { $0 + $1.size.width }
		let spaceWidth = CGFloat(cuts.count - 1) * itemSpacing
		let totalWidth = itemsWidth + spaceWidth
		let itemCoef = alignment == .fill ? (rect.width - spaceWidth) / itemsWidth : 1.0
		
		var startX: CGFloat
		switch alignment {
		case .right: startX = rect.maxX - totalWidth
		case .center: startX = rect.minX + (rect.width - totalWidth) / 2
		default: startX = rect.minX
		}
		
		var itemRect = CGRect(x: startX - itemSpacing, y: rect.minY, width: 0.0, height: rect.height)
		
		let workingCuts = reverseSection ? cuts.reversed() : cuts
		workingCuts.forEach {
			itemRect.origin.x += itemSpacing + itemRect.width
			itemRect.size.width = $1.width * itemCoef
			children[$0].layout(in: itemRect)
		}
	}
	
	
	fileprivate mutating func layoutVertical(_ alignment: UIControlContentHorizontalAlignment, in rect: CGRect) {
		let cuts = cutRow(in: rect.size)
		let spaceHeight = CGFloat(cuts.0.count - 1) * lineSpacing
		var coef = (rect.height - spaceHeight) / (cuts.1.height - spaceHeight)
		coef = coef.isNaN ? 1.0 : coef
		
		var rowRect = CGRect(x: rect.minX, y: rect.minY - lineSpacing, width: rect.width, height: 0.0)
		
		let workingCuts = reverseFill ? cuts.0.reversed() : cuts.0
		workingCuts.forEach {
			rowRect.origin.y += rowRect.height + lineSpacing
			rowRect.size.height = $0.1 * coef
			layout($0.0, alignment: alignment, in: rowRect)
		}
	}
	
	
	// MARK: Horizontal
	
	fileprivate func cutColumn(in size: CGSize) -> ([HorizontalCut], CGSize) {
		var cuts: [HorizontalCut] = []
		var column: [Cut] = []
		var height: CGFloat = -itemSpacing
		var width: CGFloat = 0.0
		var totalWidth: CGFloat = 0.0
		var maxHeight: CGFloat = 0.0
		
		for index in children.indices {
			let sizeLeft = CGSize(width: size.width, height: size.height - height)
			let childSize = children[index].sizeThatFits(sizeLeft)
			
			if height + itemSpacing + childSize.height > size.height + errorThreshold {
				if column.count > 0 { cuts.append((column, width)) }
				column.removeAll()
				totalWidth += width
				height = -itemSpacing
				width = 0.0
			}
			column.append((index, childSize))
			width = max(width, childSize.width)
			height += itemSpacing + childSize.height
			
			maxHeight = max(maxHeight, height)
		}
		if column.count > 0 { cuts.append((column, width)) }
		totalWidth += CGFloat(cuts.count - 1) * lineSpacing + width
		return (cuts, CGSize(width: totalWidth, height: maxHeight))
	}
	
	fileprivate mutating func layout(_ cuts: [Cut], alignment: UIControlContentVerticalAlignment, in rect: CGRect) {
		let itemsHeight = cuts.reduce(CGFloat(0)) { $0 + $1.size.height }
		let spaceHeight = CGFloat(cuts.count - 1) * itemSpacing
		let totalHeight = itemsHeight + spaceHeight
		let itemCoef = alignment == .fill ? (rect.height - spaceHeight) / itemsHeight : 1.0
		
		var startY: CGFloat
		switch alignment {
		case .bottom: startY = rect.maxY - totalHeight
		case .center: startY = rect.minY + (rect.height - totalHeight) / 2
		default: startY = rect.minY
		}
		
		var itemRect = CGRect(x: rect.minX, y: startY - itemSpacing, width: rect.width, height: 0.0)
		
		let workingCuts = reverseSection ? cuts.reversed() : cuts
		workingCuts.forEach {
			itemRect.origin.y += itemSpacing + itemRect.height
			itemRect.size.height = $1.height * itemCoef
			children[$0].layout(in: itemRect)
		}
		
	}
	
	fileprivate mutating func layoutHorizontal(_ alignment: UIControlContentVerticalAlignment, in rect: CGRect) {
		let cuts = cutColumn(in: rect.size)
		let spaceWidth = CGFloat(cuts.0.count - 1) * lineSpacing
		var coef = (rect.width - spaceWidth) / (cuts.1.width - spaceWidth)
		coef = coef.isNaN ? 1.0 : coef
		
		var rowRect = CGRect(x: rect.minX - lineSpacing, y: rect.minY, width: 0.0, height: rect.height)
		
		let workingCuts = reverseFill ? cuts.0.reversed() : cuts.0
		workingCuts.forEach {
			rowRect.origin.x += rowRect.width + lineSpacing
			rowRect.size.width = $0.1 * coef
			layout($0.0, alignment: alignment, in: rowRect)
		}
	}
	
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		switch direction {
		case .vertical(_): return cutRow(in: size).1
		case .horizontal(_): return cutColumn(in: size).1
		}
	}
	
	var contents: [Content] {
		return children.flatMap { $0.contents }
	}
}
