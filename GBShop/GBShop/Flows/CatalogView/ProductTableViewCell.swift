//
//  ProductTableViewCell.swift
//  GBShop
//
//  Created by Мария Коханчик on 03.10.2021.
//

import UIKit
import Kingfisher

class ProductTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDescriptionLebel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var addToBasketButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        productImageView.image = nil
        productNameLabel.text = nil
        productDescriptionLebel.text = nil
        productPriceLabel.text = nil
    }
    
    // MARK: - Methods
    
    func configureWith(product: GoodsByIdResult) {
        if !product.productImage.isEmpty,
           let imageUrl = URL(string: product.productImage) {
            productImageView.kf.setImage(with: imageUrl)
        }
        productNameLabel.text = product.productName
        productDescriptionLebel.text = product.description
        productPriceLabel.text = String(product.price) + " ₽"
    }
    
    // MARK: - Actions
    
    @IBAction func addToBasketClicked(_ sender: Any) {
    }
    
}
