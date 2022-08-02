//
//  AbbreviationCell.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//


import UIKit

class AcronymCell: UITableViewCell {
    
    private let acronymLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private let acronymDetailsLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        acronymLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(acronymLabel)
        NSLayoutConstraint.activate([
            acronymLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            acronymLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        
        acronymDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(acronymDetailsLabel)
        NSLayoutConstraint.activate([
            acronymDetailsLabel.topAnchor.constraint(equalTo: acronymLabel.bottomAnchor,constant: 5),
            acronymDetailsLabel.leadingAnchor.constraint(equalTo: acronymLabel.leadingAnchor),
            acronymDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(with model: AcronymDetails) {
        self.acronymLabel.text = model.fullForms.uppercased()
        self.acronymDetailsLabel.text = String(model.frequently) + " since " + String(model.date)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
