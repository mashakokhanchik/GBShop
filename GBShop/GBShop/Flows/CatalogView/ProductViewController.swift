//
//  ProductViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 03.10.2021.
//

import UIKit
import Kingfisher

protocol ReviewCellDelegate: AnyObject {
    
    func didPressButton(_ cell: ProductReviewTableViewCell)
    
}

class ProductViewController: BaseViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var addToBasketButton: UIButton!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var reviewsListTableView: UITableView! {
        didSet {
            reviewsListTableView.delegate = self
            reviewsListTableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    var product: GoodsByIdResult?
    var reviewsList: GetReviewListResult = []
    let catalogFabric = RequestFactory().makeGoodsDataRequestFactory()
    let reviewFabric = RequestFactory().makeReviewsRequestFactory()
    let basketFabric = RequestFactory().makeBasketFactory()
    var isAddToBasketClicked: Bool = false
    var isAddReviewClicked: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    // MARK: - Methods
    
    func loadData() {
        if let productId = productId {
            catalogFabric.getGoodsById(idProduct: productId) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(product):
                    DispatchQueue.main.async {
                        self.productPageInitWith(product: product)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func productPageInitWith(product: GoodsByIdResult) {
        self.product = product
        productNameLabel.text = product.productName
        productPriceLabel.text = String(product.price) + " руб."
        productDescriptionLabel.text = product.description
        
        let imageSource = product.productImage
        if imageSource != "",
           let image = URL(string: imageSource) {
               productImageView.kf.setImage(with: image)
           }
        productLoadReview()
    }
    
    func loadAddReviewScreen() {
        guard let addReviewViewController = AppService.shared.getScreenPage(identifier: "addReviewPage") as? AddReviewViewController else { return }
        addReviewViewController.needLoginDelegate = self
        addReviewViewController.modalPresentationStyle = .overFullScreen
        present(addReviewViewController, animated: true)
    }
    
    func productLoadReview() {
        if let productId = productId {
            reviewFabric.getReview(productId: productId) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(reviews):
                    DispatchQueue.main.async {
                        self.reviewsList = reviews
                        self.reviewsListTableView.reloadData()
                    }
                case .failure(_):
                    break
                }
            }
        }
    }
    
    private func removeReview(indexPath: IndexPath) {
        if !isNeedLogin {
            guard userNameLogin == reviewsList[indexPath.section].login else {
                return showErrorMessage(message: "Нельзя удалить чужой отзыв")
            }
            guard let idReview = reviewsList[indexPath.section].idReview else { return }
            reviewFabric.removeReview(idReview: idReview) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case .success(_):
                    self.productLoadReview()
                case .failure(_):
                    self.showErrorMessage(message: "Не удалось удалить отзыв")
                }
            }
        } else {
            login(delegate: self)
        }
    }

    // MARK: - Actions
    
    @IBAction func addToBasketClicked(_ sender: Any) {
        if isNeedLogin {
            login(delegate: self)
        } else {
            isAddToBasketClicked = true
        }
        if let productId = productId,
           let userId = appService.session.userInfo?.id {
            basketFabric.addToBasket(productId: productId,
                                     userId: userId,
                                     quantity: 1)
            { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.addToBasketButton.setTitle("Добавлен в корзину", for: .normal)
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: "Не получилось добавить в корзину")
                    }
                }
            }
        }
    }
    
    @IBAction func addReviewClicked(_ sender: Any) {
        if !isNeedLogin {
            isAddReviewClicked = true
            loadAddReviewScreen()
        } else {
            login(delegate: self)
        }
    }
    
}

extension ProductViewController: NeedLoginDelegate {

    func willDisappear(bool: Bool) {
        isAddToBasketClicked = false
        isAddReviewClicked = false
    }
    
    func willReloadData() {
        loadData()
        if isAddToBasketClicked {
            if let productId = productId,
               let userId = appService.session.userInfo?.id {
                basketFabric.addToBasket(productId: productId,
                                         userId: userId,
                                         quantity: 1)
                { [ weak self ] response in
                    guard let self = self else { return }
                    switch response.result {
                    case .success(_):
                        DispatchQueue.main.async {
                            self.addToBasketButton.setTitle("Добавлен в корзину", for: .normal)
                        }
                    case .failure(_):
                        DispatchQueue.main.async {
                            self.showErrorMessage(message: "Не получилось добавить в корзину")
                        }
                    }
                }
            }
        }
        if isAddReviewClicked {
            let addReview = appService.getScreenPage(identifier: "addReviewPage")
            present(addReview, animated: true)
        }
    }
    
}

extension ProductViewController: UITableViewDelegate, UITableViewDataSource, ReviewCellDelegate {
    
    func didPressButton(_ cell: ProductReviewTableViewCell) {
        guard let indexPath = self.reviewsListTableView.indexPath(for: cell) else { return }
        removeReview(indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        reviewsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = reviewsListTableView.dequeueReusableCell(withIdentifier: "productReviewCell") as? ProductReviewTableViewCell else {
            assertionFailure("Can't dequeue cell withIndentifier: productViewCell")
            return UITableViewCell()
        }
        cell.cellDelegate = self
        cell.configureWith(review: reviewsList[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
    }
    
}
