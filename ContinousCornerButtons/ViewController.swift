//
//  ViewController.swift
//  ContinousCornerButtons
//
//  Created by Robin Malhotra on 08/05/19.
//  Copyright © 2019 go-jek. All rights reserved.
//

import UIKit

//class RoundedButton: UIButton {
//	let roundedLayer = CALayer()
//
//	override init(frame: CGRect) {
//		<#code#>
//	}
//}

class ViewController: UIViewController {

	let button = UIButton()
	let roundedLayer = CALayer()
	let visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
	let colorView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		button.setTitle("Something", for: .normal)
		button.setTitle("Something Tapped", for: .highlighted)
		button.setBackgroundColor(.red, forState: .normal)
		button.setBackgroundColor(.blue, forState: .highlighted)
		button.clipsToBounds = true

		roundedLayer.setValue(true, forKey: "continuousCorners")
		roundedLayer.backgroundColor = UIColor.red.cgColor
		roundedLayer.masksToBounds = true
		roundedLayer.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
		self.view.layer.addSublayer(roundedLayer)
		self.view.addSubview(button)

		self.view.addSubview(visualEffectView)
		self.view.addSubview(colorView)
		colorView.backgroundColor = UIColor(red:0.17, green:0.17, blue:0.21, alpha:1.0).withAlphaComponent(0.7)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let paddingX: CGFloat = 50
		let height: CGFloat = 100
		self.button.frame = CGRect.init(x: paddingX, y: view.bounds.height/2 - height/2, width: view.bounds.width - 2 * paddingX, height: height)

		let mask = CAShapeLayer()
		// Set its frame to the view bounds
		mask.frame = self.button.bounds
		// Build its path with a smoothed shape
		mask.path = UIBezierPath(roundedRect: self.button.bounds, cornerRadius: 20.0).cgPath
		self.button.layer.mask = mask

		visualEffectView.frame = view.bounds
		colorView.frame = view.bounds
	}

}

extension UIButton {
	func setBackgroundColor(_ color: UIColor, forState controlState: UIControl.State) {
		let colorImage = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1)).image { _ in
			color.setFill()
			UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
		}
		setBackgroundImage(colorImage, for: controlState)
	}
}

