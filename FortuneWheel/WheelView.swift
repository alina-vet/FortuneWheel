//
//  WheelView.swift
//  FortuneWheel
//
//  Created by Alina Bondarchuk on 16.08.2023.
//

import UIKit

class WheelView: UIView {
    
    var wheelImageView: UIImageView!
    private var arrowImageView: UIImageView!
    private var totalScoreLabel: UILabel!
    private var lastScoreLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        wheelImageView.addGestureRecognizer(tapGesture)
        wheelImageView.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: Notification.Name("WheelTapped"), object: nil)
    }
    
    private func setupSubviews() {
        wheelImageView = UIImageView(image: UIImage(named: "wheel_image"))
        arrowImageView = UIImageView(image: UIImage(named: "arrow_image"))
        totalScoreLabel = UILabel()
        lastScoreLabel = UILabel()
        totalScoreLabel = configureLabel("Score: 0")
        totalScoreLabel.font = totalScoreLabel.font.withSize(28)
        lastScoreLabel = configureLabel("Last Win: 0")
        lastScoreLabel.font = lastScoreLabel.font.withSize(18)
        
        addSubview(wheelImageView)
        addSubview(arrowImageView)
        addSubview(totalScoreLabel)
        addSubview(lastScoreLabel)
        
        wheelImageView.translatesAutoresizingMaskIntoConstraints = false
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        totalScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        lastScoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalScoreLabel.topAnchor.constraint(equalTo: topAnchor, constant: 150),
            totalScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            lastScoreLabel.topAnchor.constraint(equalTo: totalScoreLabel.bottomAnchor, constant: 20),
            lastScoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            arrowImageView.topAnchor.constraint(equalTo: lastScoreLabel.bottomAnchor, constant: 150),
            arrowImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            arrowImageView.widthAnchor.constraint(equalToConstant: 15),
            arrowImageView.heightAnchor.constraint(equalToConstant: 15),
            
            wheelImageView.topAnchor.constraint(equalTo: arrowImageView.bottomAnchor),
            wheelImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureLabel(_ text: String) -> PaddingLabel {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        label.padding = UIEdgeInsets(top: 12, left: 18, bottom: 12, right: 18)
        label.text = text
        label.sizeToFit()
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        
        return label
    }
    
    func updateScore(_ score: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedScore = formatter.string(from: NSNumber(value: score)) {
            totalScoreLabel.text = "Score: \(formattedScore)"
        }
    }
    
    func updateLastWinScore(_ score: Int) {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        if let formattedScore = formatter.string(from: NSNumber(value: score)) {
            lastScoreLabel.text = "Last Win: \(formattedScore)"
        }
    }
}
