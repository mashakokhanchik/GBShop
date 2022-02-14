//
//  ProductReviewTableViewCell.swift
//  GBShop
//
//  Created by Мария Коханчик on 11.10.2021.
//

import UIKit

class ProductReviewTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var cellDelegate: ReviewCellDelegate?
    
    override func prepareForReuse() {
        textLabel?.text = nil
        detailTextLabel?.text = nil
    }
    
    // MARK: - Methods
    
    func configureWith(review: Review) {
        userNameLabel.text = review.login
        descriptionLabel.text = review.textReview
    }

    // MARK: - Actions
    
    @IBAction func removeReviewButtonClicked(_ sender: Any) {
        cellDelegate?.didPressButton(self)
    }
}
