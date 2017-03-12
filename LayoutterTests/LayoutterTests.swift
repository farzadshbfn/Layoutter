//
//  LayoutterTests.swift
//  LayoutterTests
//
//  Created by Farzad Sharbafian on 3/12/17.
//  Copyright © 2017 FarzadShbfn. All rights reserved.
//

import XCTest
@testable import Layoutter


/**
A simple layout type to use for testing. We can check the frame after laying
out the rect to see the effect of composing other layouts. Note that this layout's
`Content` is also a `TestLayout`, so these layouts will be at the leaves.
*/
struct TestLayout: Layout {
	typealias Content = TestLayout
	
	var frame: CGRect
	
	init(frame: CGRect = .zero) {
		self.frame = frame
	}
	
	mutating func layout(in rect: CGRect) {
		self.frame = rect
	}
	
	func sizeThatFits(_ size: CGSize) -> CGSize {
		return frame.size
	}
	
	var contents: [Content] {
		return [self]
	}
}

class VerticalDecorationLayoutTests: XCTestCase {
	
	func testSizeThatFits() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		let layout = VerticalDecoratingLayout(decoration: child1, content: child2)
		
		// Check if sizeThatFits works correctly
		let sizeThatFits = layout.sizeThatFits(CGSize(width: 100, height: 120))
		XCTAssertEqual(sizeThatFits, CGSize(width: 48, height: 104))
	}
	
	func testLayout_noAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = VerticalDecoratingLayout(decoration: child1, content: child2, alignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 50, height: 120))
		
		// Check to see that the framse are at expected values with no alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 34, height: 48))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 8, y: 64, width: 34, height: 48))
	}
	
	func testLayout_bottomAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = VerticalDecoratingLayout(decoration: child1, content: child2, alignment: .bottom)
		layout.layout(in: CGRect(x: 0, y: 0, width: 50, height: 120))
		
		// Check to see that the framse are at expected values with bottom alignment
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 34, height: 56))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 8, y: 72, width: 34, height: 40))
	}
	
	func testLayout_topAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		
		var layout = VerticalDecoratingLayout(decoration: child1, content: child2, alignment: .top)
		layout.layout(in: CGRect(x: 0, y: 0, width: 50, height: 120))
		
		// Check to see that the framse are at expected values with top alignment
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 34, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 8, y: 56, width: 34, height: 56))
	}
	
	func testLayout_topBottomAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = VerticalDecoratingLayout(decoration: child1, content: child2, alignment: .fill)
		layout.layout(in: CGRect(x: 0, y: 0, width: 50, height: 120))
		
		// Check to see that the framse are at expected values with both alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 34, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 8, y: 72, width: 34, height: 40))
	}
}


class HorizontalDecorationLayoutTests: XCTestCase {
	
	func testSizeThatFits() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		let layout = HorizontalDecoratingLayout(decoration: child1, content: child2)
		
		// Check if sizeThatFits works correctly
		let sizeThatFits = layout.sizeThatFits(CGSize(width: 100, height: 120))
		XCTAssertEqual(sizeThatFits, CGSize(width: 86, height: 56))
	}
	
	func testLayout_noAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		
		var layout = HorizontalDecoratingLayout(decoration: child1, content: child2, alignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 60))
		
		// Check to see that the framse are at expected values with no alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 38, height: 44))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 54, y: 8, width: 38, height: 44))
	}
	
	func testLayout_rightAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = HorizontalDecoratingLayout(decoration: child1, content: child2, alignment: .right)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 60))
		
		// Check to see that the framse are at expected values with no alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 44, height: 44))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 60, y: 8, width: 32, height: 44))
	}
	
	func testLayout_leftAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = HorizontalDecoratingLayout(decoration: child1, content: child2, alignment: .left)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 60))
		
		// Check to see that the framse are at expected values with no alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 30, height: 44))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 46, y: 8, width: 46, height: 44))
	}
	
	func testLayout_topBottomAlignment() {
		let child1 = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		let child2 = TestLayout(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
		
		var layout = HorizontalDecoratingLayout(decoration: child1, content: child2, alignment: .fill)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 60))
		
		// Check to see that the framse are at expected values with no alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 8, y: 8, width: 30, height: 44))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 60, y: 8, width: 32, height: 44))
	}
}



class FloatLayoutTests: XCTestCase {
	func testCenter() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .center, horizontalAlignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 35, y: 30, width: 30, height: 40))
	}
	
	func testTop() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .top, horizontalAlignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 35, y: 0, width: 30, height: 40))
	}
	
	func testBottom() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .bottom, horizontalAlignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 35, y: 60, width: 30, height: 40))
	}
	
	func testVerticalFill() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .fill, horizontalAlignment: .center)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 35, y: 0, width: 30, height: 100))
	}
	
	func testLeft() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .center, horizontalAlignment: .left)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 0, y: 30, width: 30, height: 40))
	}
	
	func testRight() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .center, horizontalAlignment: .right)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 70, y: 30, width: 30, height: 40))
	}
	
	func testHorizontalFill() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .center, horizontalAlignment: .fill)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 0, y: 30, width: 100, height: 40))
	}
	
	func testFill() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .fill, horizontalAlignment: .fill)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 0, y: 0, width: 100, height: 100))
	}
	
	func testBottomRightCorner() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = FloatLayout(child: child, verticalAlignment: .bottom, horizontalAlignment: .right)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 70, y: 60, width: 30, height: 40))
	}
	
	func testTopLeftCorner() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		var layout = child.withFloat(verticalAlignment: .top, horizontalAlignment: .left)
		layout.layout(in: CGRect(x: 0, y: 0, width: 100, height: 100))
		
		// Check to see that the frames are at expected values with given alignments
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 0, y: 0, width: 30, height: 40))
	}
}


class AspectLayoutTests: XCTestCase {
	
	func testHeightCompact() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		let layout = child.withAspect(CGSize(width: 1.0, height: 1.0))
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 200.0, height: 30.0)), CGSize(width: 30.0, height: 30.0))
	}
	
	func testWidthCompact() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		let layout = child.withAspect(CGSize(width: 1.0, height: 1.0))
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 30.0, height: 200.0)), CGSize(width: 30.0, height: 30.0))
	}
	
	func testMultiply() {
		let child = TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
		
		let layout = child.withAspect(CGSize(width: 1.0, height: 2.0))
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 30.0, height: 200.0)), CGSize(width: 30.0, height: 60.0))
	}
}


class GridLayoutTests: XCTestCase {
	var children: [TestLayout] = [
		TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 40)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 30)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 10, height: 30)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 30, height: 20)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 20, height: 10)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 50, height: 20)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 60, height: 30)),
		TestLayout(frame: CGRect(x: 0, y: 0, width: 10, height: 30)),
		]
	
	func testVertical_Size() {
		let layout = GridLayout(children: children, direction: .vertical(.left), itemSpacing: 4, lineSpacing: 8)
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 1000, height: 1000)), CGSize(width: 268, height: 40))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 1000)), CGSize(width: 78, height: 134))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 100)), CGSize(width: 78, height: 134))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 78, height: 100)), CGSize(width: 78, height: 134))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 74, height: 100)), CGSize(width: 74, height: 144))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 72, height: 100)), CGSize(width: 68, height: 182))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 10, height: 100)), CGSize(width: 60, height: 266))
	}
	
	func testVertical_Left() {
		var layout = GridLayout(children: children, direction: .vertical(.left), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 100, height: 244))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 44, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 78, y: 10, width: 10, height: 80))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 10, y: 98, width: 30, height: 40))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 44, y: 98, width: 20, height: 40))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 10, y: 146, width: 50, height: 40))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 10, y: 194, width: 60, height: 60))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 74, y: 194, width: 10, height: 60))
	}
	
	func testVertical_Right() {
		var layout = GridLayout(children: children, direction: .vertical(.right), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 100, height: 244))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 32, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 66, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 100, y: 10, width: 10, height: 80))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 56, y: 98, width: 30, height: 40))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 90, y: 98, width: 20, height: 40))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 60, y: 146, width: 50, height: 40))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 36, y: 194, width: 60, height: 60))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 100, y: 194, width: 10, height: 60))
	}
	
	func testVertical_Center() {
		var layout = GridLayout(children: children, direction: .vertical(.center), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 100, height: 244))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 21, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 55, y: 10, width: 30, height: 80))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 89, y: 10, width: 10, height: 80))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 33, y: 98, width: 30, height: 40))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 67, y: 98, width: 20, height: 40))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 35, y: 146, width: 50, height: 40))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 23, y: 194, width: 60, height: 60))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 87, y: 194, width: 10, height: 60))
	}
	
	func testVertical_Fill() {
		var layout = GridLayout(children: children, direction: .vertical(.fill), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 92, height: 244))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 36, height: 80))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 50, y: 10, width: 36, height: 80))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 90, y: 10, width: 12, height: 80))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 10, y: 98, width: 52.8, height: 40))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 66.8, y: 98, width: 35.2, height: 40))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 10, y: 146, width: 92, height: 40))
		//		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 23, y: 194, width: 75.4285714285714, height: 60))
		//		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 89.4285714285714, y: 194, width: 12.5714285714286, height: 60))
	}
	
	func testVertical_NoSpace_Left() {
		var layout = GridLayout(children: children, direction: .vertical(.left), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 8, height: 98))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 30, height: 8))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 26, width: 30, height: 6))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 10, y: 40, width: 10, height: 6))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 10, y: 54, width: 30, height: 4))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 10, y: 66, width: 20, height: 2))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 10, y: 76, width: 50, height: 4))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 10, y: 88, width: 60, height: 6))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 10, y: 102, width: 10, height: 6))
	}
	
	func testVertical_NoSpace_Right() {
		var layout = GridLayout(children: children, direction: .vertical(.right), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 8, height: 98))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: -12, y: 10, width: 30, height: 8))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: -12, y: 26, width: 30, height: 6))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 8, y: 40, width: 10, height: 6))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: -12, y: 54, width: 30, height: 4))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: -2, y: 66, width: 20, height: 2))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: -32, y: 76, width: 50, height: 4))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: -42, y: 88, width: 60, height: 6))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 8, y: 102, width: 10, height: 6))
	}
	
	func testVertical_NoSpace_Center() {
		var layout = GridLayout(children: children, direction: .vertical(.center), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 8, height: 98))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: -1, y: 10, width: 30, height: 8))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: -1, y: 26, width: 30, height: 6))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 9, y: 40, width: 10, height: 6))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: -1, y: 54, width: 30, height: 4))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 4, y: 66, width: 20, height: 2))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: -11, y: 76, width: 50, height: 4))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: -16, y: 88, width: 60, height: 6))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 9, y: 102, width: 10, height: 6))
	}
	
	func testVertical_NoSpace_Fill() {
		var layout = GridLayout(children: children, direction: .vertical(.fill), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 8, height: 98))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 8, height: 8))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 26, width: 8, height: 6))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 10, y: 40, width: 8, height: 6))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 10, y: 54, width: 8, height: 4))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 10, y: 66, width: 8, height: 2))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 10, y: 76, width: 8, height: 4))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 10, y: 88, width: 8, height: 6))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 10, y: 102, width: 8, height: 6))
	}
	
	func testHorizontal_Size() {
		let layout = GridLayout(children: children, direction: .horizontal(.top), itemSpacing: 4, lineSpacing: 8)
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 1000)), CGSize(width: 60, height: 238))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 110)), CGSize(width: 116, height: 108))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 108)), CGSize(width: 116, height: 108))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 78, height: 92)), CGSize(width: 156, height: 92))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 74, height: 76)), CGSize(width: 154, height: 74))
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 1000, height: 10)), CGSize(width: 296, height: 40))
	}
	
	func testHorizontal_Top() {
		var layout = GridLayout(children: children, direction: .horizontal(.top), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 156, height: 92))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 30, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 54, width: 30, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 48, y: 10, width: 50, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 44, width: 50, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 48, y: 68, width: 50, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 48, y: 82, width: 50, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 106, y: 10, width: 60, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 106, y: 44, width: 60, height: 30))
	}
	
	func testHorizontal_Bottom() {
		var layout = GridLayout(children: children, direction: .horizontal(.bottom), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 156, height: 92))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 28, width: 30, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 72, width: 30, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 48, y: 10, width: 50, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 44, width: 50, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 48, y: 68, width: 50, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 48, y: 82, width: 50, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 106, y: 38, width: 60, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 106, y: 72, width: 60, height: 30))
	}
	
	func testHorizontal_Center() {
		var layout = GridLayout(children: children, direction: .horizontal(.center), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 156, height: 92))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 19, width: 30, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 63, width: 30, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 48, y: 10, width: 50, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 44, width: 50, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 48, y: 68, width: 50, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 48, y: 82, width: 50, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 106, y: 24, width: 60, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 106, y: 58, width: 60, height: 30))
	}
	
	func testHorizontal_Fill() {
		var layout = GridLayout(children: children, direction: .horizontal(.fill), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 116, height: 108))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 30, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 10, y: 54, width: 30, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 10, y: 88, width: 30, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 10, width: 60, height: 24))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 48, y: 38, width: 60, height: 12))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 48, y: 54, width: 60, height: 24))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 48, y: 82, width: 60, height: 36))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 116, y: 10, width: 10, height: 108))
	}
	
	func testHorizontal_NoSpace_Top() {
		var layout = GridLayout(children: children, direction: .horizontal(.top), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 104, height: 8))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 6, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 24, y: 10, width: 6, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 38, y: 10, width: 2, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 10, width: 6, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 62, y: 10, width: 4, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 74, y: 10, width: 10, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 92, y: 10, width: 12, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 112, y: 10, width: 2, height: 30))
	}
	
	func testHorizontal_NoSpace_Bottom() {
		var layout = GridLayout(children: children, direction: .horizontal(.bottom), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 104, height: 8))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: -22, width: 6, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 24, y: -12, width: 6, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 38, y: -12, width: 2, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: -2, width: 6, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 62, y: 8, width: 4, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 74, y: -2, width: 10, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 92, y: -12, width: 12, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 112, y: -12, width: 2, height: 30))
	}
	
	func testHorizontal_NoSpace_Center() {
		var layout = GridLayout(children: children, direction: .horizontal(.center), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 104, height: 8))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: -6, width: 6, height: 40))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 24, y: -1, width: 6, height: 30))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 38, y: -1, width: 2, height: 30))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 4, width: 6, height: 20))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 62, y: 9, width: 4, height: 10))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 74, y: 4, width: 10, height: 20))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 92, y: -1, width: 12, height: 30))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 112, y: -1, width: 2, height: 30))
	}
	
	func testHorizontal_NoSpace_Fill() {
		var layout = GridLayout(children: children, direction: .horizontal(.fill), itemSpacing: 4, lineSpacing: 8)
		
		layout.layout(in: CGRect(x: 10, y: 10, width: 104, height: 8))
		
		XCTAssertEqual(layout.contents[0].frame, CGRect(x: 10, y: 10, width: 6, height: 8))
		XCTAssertEqual(layout.contents[1].frame, CGRect(x: 24, y: 10, width: 6, height: 8))
		XCTAssertEqual(layout.contents[2].frame, CGRect(x: 38, y: 10, width: 2, height: 8))
		XCTAssertEqual(layout.contents[3].frame, CGRect(x: 48, y: 10, width: 6, height: 8))
		XCTAssertEqual(layout.contents[4].frame, CGRect(x: 62, y: 10, width: 4, height: 8))
		XCTAssertEqual(layout.contents[5].frame, CGRect(x: 74, y: 10, width: 10, height: 8))
		XCTAssertEqual(layout.contents[6].frame, CGRect(x: 92, y: 10, width: 12, height: 8))
		XCTAssertEqual(layout.contents[7].frame, CGRect(x: 112, y: 10, width: 2, height: 8))
	}
}


class SizeLayoutTests: XCTestCase {
	
	func testWidth() {
		let child = TestLayout(frame: CGRect(x: 10, y: 10, width: 30, height: 50))
		let layout = child.withSize(width: 50)
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 60)), CGSize(width: 50, height: 50))
	}
	
	func testHeight() {
		let child = TestLayout(frame: CGRect(x: 10, y: 10, width: 30, height: 50))
		let layout = child.withSize(height: 70)
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 60)), CGSize(width: 30, height: 70))
	}
	
	func testSize() {
		let child = TestLayout(frame: CGRect(x: 10, y: 10, width: 30, height: 50))
		let layout = child.withSize(width: 50, height: 70)
		
		XCTAssertEqual(layout.sizeThatFits(CGSize(width: 100, height: 60)), CGSize(width: 50, height: 70))
		
		let layout2 = child.withSize(width: 50).withSize(height: 70)
		XCTAssertEqual(layout2.sizeThatFits(CGSize(width: 100, height: 60)), CGSize(width: 50, height: 70))
	}
}
