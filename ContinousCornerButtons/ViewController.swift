//
//  ViewController.swift
//  ContinousCornerButtons
//
//  Created by Robin Malhotra on 08/05/19.
//  Copyright © 2019 go-jek. All rights reserved.
//

import UIKit

protocol CTAButtonStyleProvider {
	var backgroundColor: UIColor { get }
	var pressedBackgroundColor: UIColor { get }
	var textStyles: [NSAttributedString.Key: Any] { get }
}

class CTAButton: UIButton {
	let roundedLayer = CALayer()
	let styleProvider: CTAButtonStyleProvider

	init(styleProvider: CTAButtonStyleProvider) {
		self.styleProvider = styleProvider
		super.init(frame: .zero)

		self.setBackgroundColor(styleProvider.backgroundColor, forState: .normal)
		self.setBackgroundColor(styleProvider.pressedBackgroundColor, forState: .highlighted)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		let mask = CAShapeLayer()
		// Set its frame to the view bounds
		mask.frame = self.bounds
		// Build its path with a smoothed shape
		mask.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 20.0).cgPath
		self.layer.mask = mask
	}

	override func setTitle(_ title: String?, for state: UIControl.State) {
		guard let string = title else {
			return
		}
		self.setAttributedTitle(NSAttributedString(string: string, attributes: styleProvider.textStyles), for: state)
	}
}

struct DefaultCTAStyleProvider: CTAButtonStyleProvider {
	let backgroundColor: UIColor = UIColor(red: 0.48, green: 0.32, blue: 1.00, alpha: 1.00)
	let pressedBackgroundColor: UIColor = UIColor(red: 0.69, green: 0.63, blue: 0.97, alpha: 1.00)
	let textStyles: [NSAttributedString.Key : Any] = [:]
}

class ViewController: UIViewController {

	let button = CTAButton(styleProvider: DefaultCTAStyleProvider())
	let visualEffectView = UIVisualEffectView.init(effect: UIBlurEffect.init(style: .dark))
	let colorView = UIView()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		button.setTitle("Something", for: .normal)
		button.setTitle("Something Tapped asdfunsadkfnsakdjfnksdanfdsjakfnskdfkdsajfnkdj", for: .highlighted)
		self.view.addSubview(button)

//		self.view.addSubview(visualEffectView)
//		self.view.addSubview(colorView)
		colorView.backgroundColor = UIColor(red:0.17, green:0.17, blue:0.21, alpha:1.0).withAlphaComponent(0.7)
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()

		let paddingX: CGFloat = 50
		let height: CGFloat = 100
		self.button.frame = CGRect.init(x: paddingX, y: view.bounds.height/2 - height/2, width: view.bounds.width - 2 * paddingX, height: height)

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

extension UIColor {
	func darkerBy10Percent() -> UIColor {
		var hsba: (h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) = (0,0,0,0)
		self.getHue(&(hsba.h), saturation: &(hsba.s), brightness: &(hsba.b), alpha: &(hsba.a))
		return UIColor.init(hue: hsba.h, saturation: hsba.s, brightness: hsba.b * 0.9, alpha: hsba.a)
	}
}
