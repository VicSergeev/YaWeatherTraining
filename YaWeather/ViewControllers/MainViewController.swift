//
//  ViewController.swift
//  YaWeather
//
//  Created by Vic on 23.04.2024.
//

import UIKit

// сторики remove reference


struct DayModel{
    let date: String
    let day: String
}

final class MainViewController: UIViewController {
    
    //MARK: - ДЗ (Lazy - читать) ✅
    // сделал конспект
    
    var tableView = UITableView()
    
    var dataDaySource: [DayModel] = [
        DayModel(date: "10 Апреля", day: "Вторник"),
        DayModel(date: "11 Апреля", day: "Среда"),
        DayModel(date: "12 Апреля", day: "Черверг"),
        DayModel(date: "13 Апреля", day: "Пятница"),
        DayModel(date: "14 Апреля", day: "Суббота"),
        DayModel(date: "15 Апреля", day: "Воскресенье"),
        DayModel(date: "16 Апреля", day: "Понедельник"),
        DayModel(date: "17 Апреля", day: "Вторник"),
        DayModel(date: "18 Апреля", day: "Среда"),
        DayModel(date: "19 Апреля", day: "Четверг"),
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    
    enum TBSections: Int, CaseIterable{
        case top, list
    }
    
    // DataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TBSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TBSections(rawValue: section) == .top ? 1 : dataDaySource.count
        
        // было
        //        if section == 0 {
        //            return 1
        //        } else {
        //            return 10
        //        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tbSection = TBSections(rawValue: indexPath.section)!
        // надо ли создавать отдельный файл для верхней кастомной ячейки?
        switch tbSection {
        case .top :
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderTableViewCell
            return headerCell
        case .list :
            //			let day = dataDaySourse[indexPath.row]
            let dayCell = tableView.dequeueReusableCell(withIdentifier: "DayWeatherTableViewCell", for: indexPath) as! DayWeatherTableViewCell
            
            dayCell.day = dataDaySource[indexPath.row]
            
            //			dayCell.configureCell(day.day, day.date)
            
            //MARK: - ДЗ (сделать сепаратор на всю длину)✅
            // реализовал тут, потому что в методе configureTableView ячейка не в scope
            
            let separatorView = UIView()
            separatorView.backgroundColor = UIColor.lightGray
            dayCell.addSubview(separatorView)
            
            separatorView.snp.makeConstraints { make in
                make.leading.equalTo(dayCell.snp.leading)
                make.trailing.equalTo(dayCell.snp.trailing)
                make.bottom.equalTo(dayCell.snp.bottom)
                make.height.equalTo(1.0)
            }
            
            return dayCell
            
        }
        
        //		let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        //        if indexPath.section == 0 {
        //            cell.backgroundColor = .red
        //        } else {
        //			let dayCell = tableView.dequeueReusableCell(withIdentifier: "DayWeatgetTableViewCell", for: indexPath) as! DayWeatgetTableViewCell
        //
        //
        //			return dayCell
        //
        //        }
        //
        //        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        TBSections(rawValue: indexPath.section) == .top ? 200 : 50
        
        //		indexPath.section == 0 ? 200 : 50  - короткий вариант
        
        //        if indexPath.section == 0 {
        //            return 200
        //        } else {
        //            return 55
        //        }
    }
    
    
    // tap on tb cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //		let vc = NewVC(day: TBSections(rawValue: indexPath.section) == .top ? nil : dataDaySourse[indexPath.row])
        let vc = NewVC()
        vc.day = TBSections(rawValue: indexPath.section) == .top ? nil : dataDaySource[indexPath.row]
        //		self.present(vc, animated: true)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
