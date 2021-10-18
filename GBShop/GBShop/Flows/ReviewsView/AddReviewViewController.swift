//
//  AddReviewViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 11.10.2021.
//

import UIKit

class AddReviewViewController: BaseViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var reviewTitleLabel: UILabel!
    @IBOutlet weak var textReviewTextView: UITextView!
    
    // MARK: - Properties
    
    let reviewFabric = RequestFactory().makeReviewsRequestFactory()
    var product: GoodsByIdResult? {
        return appService.session.productInfo
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let product = product {
            reviewTitleLabel.text = "Написать отзыв o: " + product.productName
        }
        reviewTitleLabel.layer.borderWidth = 0.5
        reviewTitleLabel.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        reviewTitleLabel.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Actions
    
    @IBAction func saveReviewButtonClicked(_ sender: Any) {
        guard let name = appService.session.userInfo?.login, !name.isEmpty,
              let email = appService.session.userInfo?.email, !email.isEmpty,
              let productId = productId else { return }
        guard let title = textReviewTextView.text, !title.isEmpty else {
            return showErrorMessage(message: "Заполните заголовок отзыва")
        }
        guard let textReview = textReviewTextView.text, !textReview.isEmpty else {
            return showErrorMessage(message: "Заполните поле для отзыва")
        }
        
        let review = Review(idReview: nil,
                            productId: productId,
                            login: name,
                            email: email,
                            title: title,
                            textReview: textReview)
        
        reviewFabric.addReview(productId: productId, review: review) { [ weak self ] response in
            guard let self = self else { return }
            switch response.result {
            case .success(_):
                DispatchQueue.main.async {
                    self.needLoginDelegate?.willReloadData()
                    self.showErrorMessage(message: "Отзыв добавлен", title: "Успешно") { _ in
                        self.dismiss(animated: true)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showErrorMessage(message: "Добавить отзыв не получилось")
                }
            }
        }
    }
    
    @IBAction func cancelReviewButtonClicked(_ sender: Any) {
        dismiss(animated: true)
    }
    

}
