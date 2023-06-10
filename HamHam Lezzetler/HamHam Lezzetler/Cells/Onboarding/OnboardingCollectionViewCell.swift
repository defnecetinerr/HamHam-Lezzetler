//
//  OnboardingCollectionViewCell.swift
//  HamHam
//
//  Created by Defne Çetiner on 22.04.2023.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var slideDetailLabel: UILabel!
    
    func setap(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDetailLabel.text = slide.description
    }
}
