//
//  ViewController.swift
//  SBRangeSlider
//
//  Created by Sarishti on 7/18/16.
//  Copyright © 2016 sarishti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	/// Outlet
	@IBOutlet weak var lblMaxValue: UILabel!
	@IBOutlet weak var vwSBRangeSlider: SBRangeSlider!
	@IBOutlet weak var lblMinValue: UILabel!

	/// Custom Range Slider Outlet
	var rangeSlider: SBRangeSlider!

	// MARK:- View Life cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		// This is function set the view according to screen size

	}

	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)

		// vwSBRangeSlider.layoutSubviews()

	}

	override func viewDidAppear(animated: Bool) {

		vwSBRangeSlider.setUIControls()
		self.setRangeValues(vwSBRangeSlider)

		print("vwSBRangeSlider \(vwSBRangeSlider)")
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK:- Custom function

	@IBAction func rangeSliderValueChanged(rangeSlider: SBRangeSlider) {
		self.setRangeValues(rangeSlider)

	}

	// This function is used to represent the values of range slider when user moves the thumbs

	func setRangeValues(rangeSlider: SBRangeSlider) {

		var maxValue = ""
		let minValue = String (Int(rangeSlider.selectedMinValue))

		if rangeSlider.selectedMaxValue == rangeSlider.maximumValue {
			maxValue = String(Int(rangeSlider.selectedMaxValue)) + " Above"
		} else {
			maxValue = String(Int(rangeSlider.selectedMaxValue))
		}

		self.lblMinValue.text = minValue
		self.lblMaxValue.text = maxValue
	}

}
