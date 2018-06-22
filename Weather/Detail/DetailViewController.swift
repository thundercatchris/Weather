//
//  DetailViewController.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DetailsRetreived {
    
    var id:String!
    var detailModel:DetailViewModelController!
    @IBOutlet weak var menuLabelsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var networkMessageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        activityIndicatorAnimation(enabled: true)
        detailModel = DetailViewModelController(id: id)
        detailModel.delegate = self
        detailModel?.getStoredDetails()
        menuLabelsView.layer.borderWidth = 0.5
        menuLabelsView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let days = detailModel.days {
            return days.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as! HeaderTableViewCell
        cell.sectionTitleLabel.text = detailModel.days?[section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let forecasts = detailModel.forecasts {
            return forecasts[section].count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastTableViewCell
        cell.prepareForReuse()
        if let forecast = detailModel.forecasts?[indexPath.section][indexPath.row] {
            cell.forecast = forecast
            cell.setupCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) { 
        if let forecasts = detailModel.forecasts, forecasts.count >= indexPath.section {
            cell.backgroundColor = CellColour().colorForIndex(section: indexPath.section, index: indexPath.row, sectionTotal: forecasts[indexPath.section].count)
        } else {
            cell.backgroundColor = UIColor.white
        }
    }
    
    func DetailsRetreived() {
        activityIndicatorAnimation(enabled: false)
        tableView.reloadData()
    }
    
    func activityIndicatorAnimation(enabled: Bool) {
        activityIndicator.isHidden = !enabled
        networkMessageLabel.isHidden = !enabled
        if enabled {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


