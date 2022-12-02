//
//  CustomButton.swift
//  Jokerist App
//
//  Created by jeremy.fermin 12/1/22.
//

import UIKit

struct CustomButtonVM {
    
    let text: String
    let image: UIImage?
    let backgroundColor: UIColor?
}

class CustomButton: UIButton {
    private let buttonLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        
        return label
    }()
    
    private let buttonIcon: UIImageView = {
        let icon = UIImageView()
        icon.tintColor = .white
        icon.contentMode = .scaleAspectFit
        icon.clipsToBounds = true
        
        return icon
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(buttonLabel)
        addSubview(buttonIcon)
        clipsToBounds = true
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func configure(with viewModel: CustomButtonVM) {
        buttonLabel.text = viewModel.text
        backgroundColor = viewModel.backgroundColor
        buttonIcon.image = viewModel.image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        buttonLabel.sizeToFit()
        let iconSize: CGFloat = 18
        let iconX: CGFloat = (frame.size.width - buttonLabel.frame.size.width - iconSize - 5) / 2
        buttonIcon.frame = CGRect(x: iconX,
                                y: (frame.size.height-iconSize)/2,
                                width: iconSize,
                                height: iconSize)
        buttonLabel.frame = CGRect(x: iconX + iconSize + 5,
                                y: 0,
                                width: buttonLabel.frame.size.width,
                                height: frame.size.height)
    }
}
