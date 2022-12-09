//
//  CustomCell.swift
//  Jokerist App
//
//  Created by jeremy.fermin 12/1/22.
//

import Foundation
import UIKit

import UIKit

class CustomCell: UITableViewCell {

    let setup = UILabel()
    let punchline = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup.translatesAutoresizingMaskIntoConstraints = false
        setup.numberOfLines = 5
        setup.sizeToFit()
        
        punchline.translatesAutoresizingMaskIntoConstraints = false
        punchline.sizeToFit()
        
        contentView.addSubview(setup)
        contentView.addSubview(punchline)
        
        NSLayoutConstraint.activate([
            setup.topAnchor.constraint(equalTo: contentView.topAnchor),
            setup.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            setup.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            setup.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            punchline.leadingAnchor.constraint(equalTo: setup.leadingAnchor),
            punchline.topAnchor.constraint(equalTo: setup.bottomAnchor),
            punchline.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
