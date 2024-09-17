//
//  SECircularCountDownView.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 02.12.2023.
//

import UIKit

/// Protocol for handling countdown completion events.
public protocol SECircularCountDownViewDelegate: AnyObject {
    /// Called when the countdown finishes.
    func timeOver(countDownView: SECircularCountDownView)
}

open class SECircularCountDownView: UIView {

    private lazy var countDownLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let endPoint = CGFloat(3 * Double.pi / 2)
    private let startPoint = CGFloat(-Double.pi / 2)
    private weak var timer: Timer?

    /// The color of the progress bar.
    @IBInspectable public var progressColor: UIColor = .white {
        didSet {
            updateLayers()
        }
    }

    /// The color of the background track of the progress bar.
    @IBInspectable public var trackColor: UIColor = .white.withAlphaComponent(0.5) {
        didSet {
            updateLayers()
        }
    }

    /// The color of the text in the countdown label.
    @IBInspectable public var textColor: UIColor = .black {
        didSet {
            countDownLabel.textColor = textColor
        }
    }

    /// The width of the progress and track bars.
    @IBInspectable public var barWidth: CGFloat = 5.0 {
        didSet {
            updateLayers()
        }
    }

    /// The font of the countdown label.
    public var font: UIFont = .systemFont(ofSize: 18, weight: .bold) {
        didSet {
            countDownLabel.font = font
        }
    }

    /// The duration of the countdown in seconds.
    @IBInspectable public var duration: Int = 0 {
        didSet {
            self.updateLabel(remainingTime: duration)
        }
    }

    /// The suffix to append to the countdown label's text.
    @IBInspectable public var countDownLabelSuffix: String = ""

    /// The delegate to notify when the countdown finishes.
    public weak var delegate: SECircularCountDownViewDelegate?

    // MARK: - Initializers

    /// Initializes the view with a frame.
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    /// Initializes the view from a storyboard or xib.
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    /// Common initialization code.
    open func commonInit() {
        updateLayers()
        countDownLabel.font = font
        countDownLabel.textColor = textColor
        countDownLabel.textAlignment = .center
        countDownLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(countDownLabel)
        countDownLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        countDownLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }

    // MARK: - Private Methods

    /// Updates the layers for the progress and track bars.
    open func updateLayers() {
        backgroundLayer.removeFromSuperlayer()
        progressLayer.removeFromSuperlayer()
        let path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2.0, y: self.frame.size.height / 2.0),
                                radius: frame.size.width / 2.0,
                                startAngle: startPoint,
                                endAngle: endPoint,
                                clockwise: true)

        backgroundLayer.path = path.cgPath
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineWidth = barWidth
        backgroundLayer.strokeColor = trackColor.cgColor
        self.layer.addSublayer(backgroundLayer)

        progressLayer.path = path.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = barWidth
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.strokeEnd = 0
        self.layer.addSublayer(progressLayer)
    }

    /// Updates the countdown label with the remaining time.
    open func updateLabel(remainingTime: Int) {
        self.countDownLabel.text = "\(remainingTime)" + countDownLabelSuffix
    }

    // MARK: - Public Methods

    /// Starts the countdown and animates the progress layer.
    open func start() {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = CFTimeInterval(self.duration)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: "progressAnimation")

        timer?.invalidate()
        var remainingTime = duration
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
            guard let self = self else { return }
            self.updateLabel(remainingTime: remainingTime)
            remainingTime -= 1

            if remainingTime < 0 {
                timer.invalidate()
                self.delegate?.timeOver(countDownView: self)
            }
        }
        timer?.fire()
    }
}
