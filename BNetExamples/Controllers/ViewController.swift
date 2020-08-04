//
//  ViewController.swift
//  BNetExamples
//
//  Created by Berkay Vurkan on 1.08.2020.
//  Copyright © 2020 Foo. All rights reserved.
//

import UIKit
import BNet

class ViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var currencyIdLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var countryTableView: UITableView! {
        didSet {
            self.countryTableView.tableFooterView = UIView(frame: .zero)
        }
    }
    @IBOutlet weak var noDataLabel: UILabel!

    // MARK: - Properties
    var isDarkModeOn = false
    var isRequestActive = false
    var refreshControl: UIRefreshControl?
    var countries = [CountryModel]() {
        didSet {
            self.noDataLabel.isHidden = !self.countries.isEmpty
            if self.countryTableView != nil {
                setTableView(self.countryTableView)
            }
        }
    }

    // MARK: - Main
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }

    func initView() {
        if #available(iOS 12.0, *) {
            self.isDarkModeOn = self.traitCollection.userInterfaceStyle == .dark
        }

        if isDarkModeOn {
            self.bannerView.backgroundColor = .black
        }
        self.currencyIdLabel.text = NSLocalizedString("", comment: "")
        self.currencyNameLabel.text = NSLocalizedString("Please select a country.", comment: "")
        getCountries()
    }

    func setTableView(_ tableView: UITableView) {
        if tableView.delegate == nil {
            tableView.delegate = self
            tableView.dataSource = self
        }
        tableView.tableFooterView = UIView(frame: .zero)
        addRefreshControl(tableView)
        DispatchQueue.main.async {
            if let refresh = self.refreshControl, refresh.isRefreshing {
                refresh.endRefreshing()
            }
            tableView.reloadData()
        }
    }

    func addRefreshControl(_ tableView: UITableView) {
        if self.refreshControl == nil {
            self.refreshControl = UIRefreshControl()
            self.refreshControl?.tintColor = UIColor.gray
            self.refreshControl?.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
            tableView.addSubview(refreshControl!)
        }
    }

    // MARK: - Actions
    @objc func refreshTableView() {
        if !self.isRequestActive {
            getCountries()
        }
    }

    func endRefreshing() {
        if let refreshControl = self.refreshControl, refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
}

// MARK: - Service Calling
extension ViewController {

    func getCountries() {
        let router = BNetManager.shared.accessRouter(endpointType: CountriesEndpoint<CountryModel>.self)
        self.isRequestActive = true
        router.request(.listAll, decoded: CountryListResponseModel.self, onSuccess: { (model) in
            self.countries = model.results.map { CountryModel(response: $0.value) }
            self.countries.sort { $0.name.lowercased() < $1.name.lowercased() }
            self.isRequestActive = false
        }, onFailure: { (err) in
            self.noDataLabel.isHidden = false
            self.isRequestActive = false
            let popup = UIAlertController(title: "Error", message: err.description, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                self.endRefreshing()
                self.noDataLabel.isHidden = !self.countries.isEmpty
                return
            })
            let refreshAction = UIAlertAction(title: "Try again", style: .default, handler: { _ in
                self.getCountries()
                return
            })
            popup.addAction(cancelAction)
            popup.addAction(refreshAction)
            self.present(popup, animated: true, completion: nil)
        })
    }
}

// MARK: - Table View
extension ViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        if indexPath.row < self.countries.count {
            let item = self.countries[indexPath.row]
            cell.textLabel?.text = item.name
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row < self.countries.count {
            self.currencyNameLabel.text = self.countries[indexPath.row].currency.name.capitalized
            self.currencyIdLabel.text = self.countries[indexPath.row].currency.id.uppercased()
        }
    }
}
