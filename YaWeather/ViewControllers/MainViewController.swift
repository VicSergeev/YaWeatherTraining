//
//  ViewController.swift
//  YaWeather
//
//  Created by Vic on 23.04.2024.
//

import UIKit

// сторики remove reference

final class MainViewController: UIViewController {
    
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
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
        
        //set constraints
        tableView.pin(to: view)
    }
    
    func setTableViewDelegates() {
        tableView.delegate = self // MainVC
        tableView.dataSource = self
    }
}

// MARK: - TVDataSource & TVDelegate protocols
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        if indexPath.section == 0 {
            cell.backgroundColor = .red
        } else {
            cell.backgroundColor = .orange
        }
        
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 200
        } else {
            return 55
        }
    }
}
