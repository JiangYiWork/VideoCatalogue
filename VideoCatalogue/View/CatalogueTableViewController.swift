//
//  CatalogueTableViewController.swift
//  VideoCatalogue
//
//  Created by Yi JIANG on 27/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import UIKit

class CatalogueTableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    lazy var viewModel: CatalogueViewModel = {
        return CatalogueViewModel()
    }()
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    private func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 143
        tableView.rowHeight = UITableView.automaticDimension
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    private func initViewModel() {
        //Events and Data binding
        viewModel.showAlert = { [weak self] () in
            DispatchQueue.main.async {
                guard let strongSelf = self,
                    let message = strongSelf.viewModel.alertMessage
                    else { return }
                strongSelf.showAlert(message)
            }
        }
        
        viewModel.hasError = { (error) in
            DispatchQueue.main.async {
                print(error.errorDescription ?? "No error Description")
            }
        }
        
        viewModel.didUpdateCatalogue = { [weak self] () in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }
        
        viewModel.updateLoadingStatus = { [weak self] () in
            DispatchQueue.main.async {
                let isLoading = self?.viewModel.isLoading ?? false
                if isLoading {
                    self?.loadingIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 0.0
                    })
                }else {
                    self?.loadingIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self?.tableView.alpha = 1.0
                    })
                }
            }
        }
        
        viewModel.fetchCatalogue()
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func pullToRefresh() {
        viewModel.fetchCatalogue()
    }
    
}

extension CatalogueTableViewController: UITableViewDelegate, UITableViewDataSource {
        
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.getCatalogueTitle(for: section)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogueCell", for: indexPath) as! CatalogueTableViewCell
        cell.catalogue = viewModel.catalogue[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let isFeatures = viewModel.catalogue[indexPath.section].category?.caseInsensitiveCompare("Features") == .orderedSame
        return isFeatures ? 143 : 205
    }

    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            if headerView.textLabel?.text?.caseInsensitiveCompare("TV Shows") == .orderedSame {
                headerView.textLabel?.text? = "TV Shows"
            } else {
                headerView.textLabel?.text? = headerView.textLabel?.text?.capitalized ?? ""
            }
            headerView.textLabel?.font = headerView.textLabel?.font.withSize(20)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

    

}
