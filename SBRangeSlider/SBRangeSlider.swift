//
//  SBRangeSlider.swift
//  SBRangeSlider
//
//  Created by Sarishti on 7/18/16.
//  Copyright © 2016 sarishti. All rights reserved.
//

import UIKit

@IBDesignable
class SBRangeSlider: UIControl {

	// MARK: -  Properties of SBRangeSlider

	/// Minimum value and maximum values
	var minimumValue: Float!
	var maximumValue: Float!

	/// Minimum Range between two thumbs
	var minimumRange: Float!

	/// Selected Minimum and maximum values
	var selectedMinValue: Float!
	var selectedMaxValue: Float!
	// move the thumb to particular x value from the thumb image
	var distanceFromCenter: CGFloat!
	// Distance from the center of the thumb from the staring and ending point of view
	var padding: CGFloat = 17

	/// Default Max and min thumb values on means enable to move

	var maxThumbOn: Bool = false
	var minThumbOn: Bool = false

	/// min and max thumb images

	var minThumb: UIImageView!
	var maxThumb: UIImageView!

	/// track image to represent the selected area between two thumbs  and track background represents the default track
	var track: UIImageView!
	var trackBackground: UIImageView!

	// MARK: To get the values from attribute Inspector

	@IBInspectable internal var minVal: Float = 1.0 {
		didSet {
			minimumValue = minVal
		}
	}

	@IBInspectable internal var maxVal: Float = 50.0 {
		didSet {
			maximumValue = maxVal
		}
	}

	@IBInspectable internal var minRange: Float = 10.0 {
		didSet {
			minimumRange = minRange
		}
	}
	@IBInspectable internal var selectedMaximumVal: Float = 20.0 {
		didSet {
			selectedMaxValue = selectedMaximumVal
		}
	}
	@IBInspectable internal var selectedMinimumVal: Float = 1.0 {
		didSet {
			selectedMinValue = selectedMinimumVal
		}
	}

	@IBInspectable var thumbImage: UIImage = UIImage(named: "range_selector_dot.png")! {
		didSet {
			minThumb = UIImageView(image: thumbImage, highlightedImage: thumbImage)
			maxThumb = UIImageView(image: thumbImage, highlightedImage: thumbImage)

		}
	}
	@IBInspectable var trackImg: UIImage = UIImage(named: "range_selector_line_yellow.png")! {
		didSet {
			track = UIImageView(image: trackImg, highlightedImage: trackImg)
		}
	}

	@IBInspectable var trackBgImg: UIImage = UIImage(named: "range_selector_line_gray.png")! {
		didSet {
			trackBackground = UIImageView(image: trackBgImg, highlightedImage: trackBgImg)

		}
	}

	override init(frame: CGRect) {
		super.init(frame: frame)

	}

	required init?(coder aDecoder: NSCoder) {

		super.init(coder: aDecoder)

	}

	// MARK: Initialize UI controls for view

	func setUIControls() {

		self.layoutIfNeeded()
		self.setTrackImages()
		self.setThumbImages()

	}

	// MARK:  Custom Function

	/**
     Set the max and min thumb images
     */

	func setThumbImages() {

		guard let _ = minThumb, _ = maxThumb else {
			self.setDefaultThumbImages()
			print("Please place images")
			return
		}

		let thumbImagesFrame = CGRect.init(x: 0, y: 0, width: self.frame.size.height, height: self.frame.size.height)

		minThumb.frame = thumbImagesFrame
		minThumb.contentMode = UIViewContentMode.Center
		self.addSubview(minThumb)
		minThumb.bringSubviewToFront(self)

		maxThumb.frame = thumbImagesFrame
		maxThumb.contentMode = UIViewContentMode.Center
		self.addSubview(maxThumb)

	}

	/**
     Set the track and selected track images
     */

	func setTrackImages() {
		guard let _ = trackBackground, _ = track
		else {
			self.setDefaultThumbImages()
			print("Please place images")
			return
		}
		trackBackground.frame = CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: trackImg.size.height)
		// Set the view center
		trackBackground.center = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
		trackBackground.contentMode = UIViewContentMode.ScaleToFill
		self.addSubview(trackBackground)

		track.center = CGPoint.init(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0)
		self.addSubview(track)

	}

	// MARK:  Set default images if user not selected
	/**
     Track images deaflut set from images folder
     */

	func setDefaultTrackImages() {
		var img = UIImage(named: "range_selector_line_gray.png")!
		trackBackground = UIImageView(image: img, highlightedImage: img)
		img = UIImage(named: "range_selector_line_yellow.png")!
		track = UIImageView(image: img, highlightedImage: img)
	}

	/**
     Thumb images defalut set from images folder
     */
	func setDefaultThumbImages() {
		let img = UIImage(named: "range_selector_dot.png")!
		minThumb = UIImageView(image: img, highlightedImage: img)
		maxThumb = UIImageView(image: img, highlightedImage: img)
	}

	// MARK:  Thumbs position and values Update

	// This fucntion is called to set the minimum and maximum thum position

	override func layoutSubviews() {

		// Set the initial state
		guard let _ = minThumb, _ = maxThumb, _ = track, _ = trackBackground else {
			setDefaultTrackImages()
			setDefaultThumbImages()
			print("SubViews values")
			return
		}

		self.minThumb.center = CGPoint(x: self.xForValue(selectedMinValue), y: trackBackground.center.y)
		self.maxThumb.center = CGPoint(x: self.xForValue(selectedMaxValue), y: trackBackground.center.y)
		NSLog("Tapable size \( minThumb.bounds.size.width) max: \(maxThumb.bounds.size.width) \(self.minThumb.center) \(self.maxThumb.center)")
		self.updateTrackHighlight()
	}

	// This function used to return the x value of thumb according to the selected minimum value

	func xForValue(value: Float) -> CGFloat {

		let widthAfterPadding = self.frame.size.width - (padding * 2)
		let diffOfValues = maximumValue - minimumValue
		return widthAfterPadding * CGFloat(((value - minimumValue) / diffOfValues)) + padding
	}

	// This function return the selected minimum or maximum value according to the thumb position

	func valueForX(xValue: CGFloat) -> CGFloat {
		self.layoutIfNeeded()
		let widthAfterPadding = self.frame.size.width - padding * 2
		let diffOfValues: CGFloat = CGFloat(maximumValue - minimumValue)
		return CGFloat(minimumValue) + (xValue - padding) / widthAfterPadding * diffOfValues
	}

	// MARK: Update Selected Track

	// This function is used to upadte the frames when user continue to move thumbs

	func updateTrackHighlight() {

		self.track.frame = CGRect.init(x: minThumb.center.x, y: track.center.y - (track.frame.size.height / 2), width: maxThumb.center.x - minThumb.center.x, height: track.frame.size.height)
	}

	// MARK: Touch functions  override

	override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		if !minThumbOn && !maxThumbOn {
			return true
		}
		let touchPoint: CGPoint = touch.locationInView(self)
		if minThumbOn {
			self.minThumb.center = CGPoint(x: max(self.xForValue(minimumValue), min(touchPoint.x - distanceFromCenter, self.xForValue(selectedMaxValue - minimumRange))), y: minThumb.center.y)
			selectedMinValue = Float(self.valueForX(minThumb.center.x))
		}
		if maxThumbOn {
			self.maxThumb.center = CGPoint(x: min(self.xForValue(maximumValue), max(touchPoint.x - distanceFromCenter, self.xForValue(selectedMinValue + minimumRange))), y: maxThumb.center.y)
			selectedMaxValue = Float(self.valueForX(maxThumb.center.x))
		}
		self.updateTrackHighlight()
		self.setNeedsLayout()
		self.sendActionsForControlEvents(.ValueChanged)
		return true
	}

	override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
		let touchPoint: CGPoint = touch.locationInView(self)

		if CGRectContainsPoint(minThumb.frame, touchPoint) {
			self.minThumbOn = true
			distanceFromCenter = touchPoint.x - minThumb.center.x
		} else if CGRectContainsPoint(maxThumb.frame, touchPoint) {
			self.maxThumbOn = true
			distanceFromCenter = touchPoint.x - maxThumb.center.x
		} else { return false
		}
		return true
	}

	override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
		self.minThumbOn = false
		self.maxThumbOn = false
	}

}
