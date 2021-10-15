//
//  CatalogTableViewController.swift
//  GBShop
//
//  Created by Мария Коханчик on 03.10.2021.
//

import UIKit

class CatalogTableViewController: BaseViewController {
        
    // MARK: - Outlets
    
    @IBOutlet weak var catalogTableView: UITableView!
    
    // MARK: - Properties
    
    var catalogFactory = RequestFactory().makeGoodsDataRequestFactory()
    var productList: [GoodsByIdResult] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Каталог"
        
        catalogTableView.delegate = self
        catalogTableView.dataSource = self
        catalogTableView.register(UINib(nibName: "ProductViewCell", bundle: nil),
                                  forCellReuseIdentifier: "productViewCell")
        
        catalogFactory.getCatalogData { response in
            switch response.result {
            case .success(let catalogDataResult):
                DispatchQueue.main.async {
                    self.productList = catalogDataResult
                    self.catalogTableView.reloadData()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.showErrorMessage(message: "Ошибка отображения каталога")
                }
            }
        }

    }
}
    
// MARK: - Table view delegate

extension CatalogTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let productViewController = AppService.shared.getScreenPage(identifier: "productDetailScreen") as? ProfileViewController {
            self.appService.session.setProductInfo(productList[indexPath.row])
            navigationController?.pushViewController(productViewController, animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

// MARK: - Table view data source

extension CatalogTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productViewCell", for: indexPath) as? ProductTableViewCell
        else {
            assertionFailure("Can't dequeue reusable cell withIdentifier: productViewCell")
            return UITableViewCell()
        }
        cell.configureWith(product: productList[indexPath.row])
        return cell
    }

}
