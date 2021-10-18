//
//  BasketTableViewCell.swift
//  GBShop
//
//  Created by Мария Коханчик on 15.10.2021.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    
    // MARK: - Outlets
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    // MARK: - Properties
    
    override func prepareForReuse() {
        productNameLabel.text = nil
        productPriceLabel.text = nil
        quantityLabel.text = nil
        totalPriceLabel.text = nil
    }

    // MARK: - Methods
    
    func configureWith(_ product: BasketItems) {
        productNameLabel.text = product.productName
        productPriceLabel.text = String(product.productPrice) + " руб."
        quantityLabel.text = String(product.quantity) + " шт."
        totalPriceLabel.text = "Итого: " + String(product.productPrice * product.quantity) + " руб."
    }

}
