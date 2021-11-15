//
//  BasketViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 15.10.2021.
//

import UIKit

class BasketViewController: BaseViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var basketTableView: UITableView! {
        didSet {
            basketTableView.delegate = self
            basketTableView.dataSource = self
        }
    }
    @IBOutlet weak var cleanBasketButton: UIButton!
    @IBOutlet weak var goodsCountTitleLabel: UILabel!
    @IBOutlet weak var totalPriceTitleLabel: UILabel!
    @IBOutlet weak var goodsCountLabel: UILabel!
    @IBOutlet weak var totalPreceLabel: UILabel!
    @IBOutlet weak var payBasketButton: UIButton!
    
    @IBOutlet weak var isNeedLoginLabel: UILabel!
    @IBOutlet weak var isNeedLoginButton: UIButton!
   
    // MARK: - Properties
    
    var basket: GetBasketResult?
    var items: [BasketItems] = []
    let basketFabric = RequestFactory().makeBasketFactory()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !isNeedLogin {
            willDisappear(bool: false)
        } else {
            willDisappear(bool: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        if !isNeedLogin {
            loadBasket()
        } else {
            login(delegate: self)
            isNeedLoginLabel.text = "Необходима авторизация"
            isNeedLoginButton.setTitle("Войти", for: .normal)
        }
    }
    
    // MARK: - Methods
    
    func toggleBasketInterface(hide: Bool = true) {
        basketTableView.isHidden = hide
        cleanBasketButton.isHidden = hide
        goodsCountTitleLabel.isHidden = hide
        totalPriceTitleLabel.isHidden = hide
        goodsCountLabel.isHidden = hide
        totalPreceLabel.isHidden = hide
        payBasketButton.isHidden = hide
        isNeedLoginLabel.isHidden = !hide
        if items.count > 0 {
            isNeedLoginButton.isHidden = !hide
        } else if !isNeedLogin {
            isNeedLoginButton.isHidden = hide
        } else {
            isNeedLoginButton.isHidden = !hide
        }
    }
    
    // MARK: - Private methods
    
    func loadBasket() {
        if let userId = userId {
            basketFabric.getBasket(userId: userId) { response in
                switch response.result {
                case let .success(basketResult):
                    DispatchQueue.main.async {
                        self.basket = basketResult
                        self.items = basketResult.basketItems
                        self.basketTableView.reloadData()
                        
                        if basketResult.itemsCount > 0 {
                            self.willDisappear(bool: false)
                            self.totalPreceLabel.text = String(self.basket?.amount ?? 0)
                            self.goodsCountLabel.text = String(self.basket?.itemsCount ?? 0)
                        } else {
                            self.willDisappear(bool: true)
                            self.isNeedLoginLabel.text = "Корзина пуста"
                        }
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self.willDisappear(bool: true)
                        self.isNeedLoginLabel.text = "Невозможно загрузить данные"
                        self.showErrorMessage(message: "Невозможно загрузить данные")
                    }
                }
            }
        } else {
            willDisappear(bool: true)
            isNeedLoginLabel.text = "Невозможно загрузить данные"
        }
    }
    
    private func cleanBasket() {
        if let userId = userId {
            basketFabric.clearBasket(userId: userId) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case .success(_):
                    self.loadBasket()
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: "Не удалось очистить корзину")
                    }
                }
            }
        }
    }
    
    private func deleteFromBasket(indexPath: IndexPath) {
        if let userId = userId {
            let productId = items[indexPath.row].productId
            basketFabric.deleteFromBasket(productId: productId,
                                          userId: userId) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case .success(_):
                    self.loadBasket()
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: "Не удалось удалить товар из корзины")
                    }
                }
            }
        }
    }
    
    // MARK: - Actions

    @IBAction func payBasketClicked(_ sender: Any) {
        if let userId = userId,
           let amount = basket?.amount {
            basketFabric.payBasket(userId: userId,
                                   paySumm: amount) { [ weak self ] response in
                guard let self = self else { return }
                switch response.result {
                case let .success(payResult):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: payResult.userMessage/*?? "Заказ оплачен"*/, title: "Успешно")
                    }
                    self.cleanBasket()
                case .failure(_):
                    DispatchQueue.main.async {
                        self.showErrorMessage(message: "Ошибка оплаты заказа")
                    }
                }
            }
        }
    }
    
    @IBAction func cleanBasketButton(_ sender: Any) {
        cleanBasket()
    }
    
    @IBAction func isNeedLoginButton(_ sender: Any) {
        login(delegate: self)
    }

}

extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = basketTableView.dequeueReusableCell(withIdentifier: "basketCell") as? BasketTableViewCell else {
            assertionFailure("Can't dequeue reusable cell withIdentifier: basketCell")
            return UITableViewCell()
        }
        cell.configureWith(items[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let actionProvider: UIContextMenuActionProvider = { _ in
            return UIMenu(children: [
                UIAction(title: "Удалить", image: UIImage(systemName: "trash")) { _ in
                    self.deleteFromBasket(indexPath: indexPath)}
            ])
        }
        return UIContextMenuConfiguration(identifier: nil,
                                          previewProvider: nil,
                                          actionProvider: actionProvider)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteButton = UIContextualAction(style: .destructive, title: "Удалить") { _,_,_ in
            self.deleteFromBasket(indexPath: indexPath)
        }
        deleteButton.backgroundColor = .blue
        let configuration = UISwipeActionsConfiguration(actions: [deleteButton])
        configuration.performsFirstActionWithFullSwipe = true
        configuration.accessibilityActivate()
        
        return configuration
    }
}

extension BasketViewController: NeedLoginDelegate {
    func willReloadData() {
        self.loadBasket()
    }
    
    func willDisappear(bool: Bool) {
        toggleBasketInterface(hide: bool)
        isNeedLoginLabel.isHidden = !bool
    }
    
}
