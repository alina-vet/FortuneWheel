//
//  ViewController.swift
//  FortuneWheel
//
//  Created by Alina Bondarchuk on 16.08.2023.
//

import UIKit

class ViewController: UIViewController, CAAnimationDelegate {
    
    private let model = WheelModel()
    private var wheelView: WheelView!
    private var previousPoints: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wheelView = WheelView(frame: view.bounds)
        wheelView.updateScore(model.getTotalScore())
        view.addSubview(wheelView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(startAnimation), name: Notification.Name("WheelTapped"), object: nil)
    }
    
    @objc private func startAnimation() {
        let spinResult = model.spinWheel()
        animateWheel(spinResult.stoppingSection)
    }

    private func animateWheel(_ stoppingSection: Int) {
        let revolutions = 5
        let totalRotation = CGFloat(revolutions) * 360.0
        let randomSectionAngle = CGFloat(stoppingSection) * (360.0 / 16.0)
        
        let finalRotationAngle = .pi * totalRotation / 180.0 + .pi * randomSectionAngle / 180.0
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = finalRotationAngle
        rotationAnimation.duration = 3.0
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        rotationAnimation.fillMode = .forwards
        rotationAnimation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.wheelView.updateScore(self.model.getTotalScore())
            self.wheelView.updateLastWinScore(self.model.getlastScore())
            self.model.saveTotalScore()
        }
                wheelView.wheelImageView.layer.add(rotationAnimation, forKey: "spinAnimation")
        CATransaction.commit()
    }
}
