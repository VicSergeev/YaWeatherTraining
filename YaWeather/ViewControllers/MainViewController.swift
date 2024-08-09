//
//  ViewController.swift
//  YaWeather
//
//  Created by Vic on 23.04.2024.
//

import UIKit

final class MainViewController: UIViewController {
    
    var tableView = UITableView()
    var dataStore = DataStore.shared
    var fact: Fact? {
        didSet {
            guard fact != nil else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var forecasts: ForecastResponse? {
        didSet {
            guard forecasts != nil else {return}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
//    var hourly: [ForecastResponse?] {
//        didSet {
//            guard hourly != nil else {return}
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
    
    // here var icon: Fact? {guard icon else {return}}
    
    struct Cells {
        static let dayWeatherCell = "DayWeatherTableViewCell"
        static let headeCell = "HeaderCell"
    }
    
    // MARK: - Here getIcon variable via DispatchQueue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        view.backgroundColor = .white.withAlphaComponent(0)
        
        NetworkManager().fetchWeather(lat: "47.1752", lon: "39.3528") { [weak self] result, error in
            guard let result else {
                print(error?.localizedDescription ?? "error fetchWeather" )
                return
            }
            self?.fact = result.fact
            //print(result)
        }
        
        // ‼️ another api caller here
        NetworkManager().fetchHourly(key: Configure.hourlyWeatherAPIKey, location: "Rostov-on-Don", days: "1", aqi: "no", alerts: "no") { result, error in
            guard let result else {
                print(error?.localizedDescription ?? "error fetching hourly" )
                return
            }
            self.forecasts = result
//            result.forecastday
            print(result.forecast.forecastday.count)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

// MARK: - UITableView Settings
private extension MainViewController {
    func configureTableView() {
        // add TV on main view
        view.addSubview(tableView)
        // set delegates
        setTableViewDelegates()
        // register cells
        tableView.register(DayWeatherTableViewCell.self, forCellReuseIdentifier: "DayWeatherTableViewCell")
        tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: "HeaderCell")
		tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(white: 1, alpha: 0.3)
        tableView.contentInsetAdjustmentBehavior = .never
        // set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self // MainVC
        tableView.dataSource = self
    }
}

// MARK: - TVDataSource & TVDelegate protocols
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    enum TBSections: Int, CaseIterable{
        case top, list
    }
    
    // MARK: - TVDataSource
    // передаём кейсы
    func numberOfSections(in tableView: UITableView) -> Int {
        return TBSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TBSections(rawValue: section) == .top ? 1 : dataStore.dataDaySource.count
    }
    
    // MARK: - TVDelegate
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tbSection = TBSections(rawValue: indexPath.section)!
        switch tbSection {
        case .top :
            let headerCell = tableView.dequeueReusableCell(withIdentifier: Cells.headeCell, for: indexPath) as! HeaderTableViewCell
            if let fact, let forecasts {
                headerCell.fill(fact, forecast: forecasts)
            }
            return headerCell
        case .list :
            let dayCell = tableView.dequeueReusableCell(withIdentifier: Cells.dayWeatherCell, for: indexPath) as! DayWeatherTableViewCell
            dayCell.day = dataStore.dataDaySource[indexPath.row]
            return dayCell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard TBSections(rawValue: indexPath.section) == .list else {
            return
        }
        let vc = DetailViewController()
        vc.day = TBSections(rawValue: indexPath.section) == .top ? nil : dataStore.dataDaySource[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
