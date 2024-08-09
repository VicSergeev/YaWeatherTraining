//
//  HeaderTableViewCell + UICollection Protocols.swift
//  YaWeather
//
//  Created by Vic on 20.05.2024.
//

import UIKit

// MARK: - Collection views enumeration extension
extension HeaderTableViewCell {
    enum CVSections: Int, CaseIterable { // !!! Int, CaseIterable !!!
        case conditions, nextHours
    }
    
    // MARK: - Focus group created
    enum CVFocus: String{
        case conditionsCellsWithTwoSections = "infoCollectionView"
        case pageControlCells = "viewsCollectionView"
    }
    
}
