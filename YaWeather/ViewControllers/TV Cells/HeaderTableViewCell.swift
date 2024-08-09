//
//  ViewController.swift
//  YaWeather
//
//  Created by Vic on 30.04.2024.
//

import UIKit
import SnapKit

//MARK: - ДЗ : (generics✅, typealias✅, associatedtype✅, collectionViewLayout✅)

class HeaderTableViewCell: BaseTableViewCell {
	
    private let dataStore = DataStore.shared
    
    // 5️⃣ - начало в CustomView
	lazy private var customView: CustomView = {
//		CustomView.instanceFromNib()
        let view = CustomView.instanceFromNib()
        view.backgroundColor = .sunset.withAlphaComponent(0.3)
        return view
	}()
    
    // MARK: - Collection view вёрстка
    
    // StackView
	lazy private var collectionsStackView: UIStackView = {
		var stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 5
		stackView.distribution = .fillEqually
		return stackView
	}()
	
    // Upper collection wind/pressure etc
	lazy private var conditionsCollectionViewWithTwoSections: UICollectionView = {
        // FlowLayout setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        // ‼️ other setups in layout delegate protocol methods down below ‼️
        
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.delegate = self
		cv.dataSource = self
        cv.showsHorizontalScrollIndicator = false
        cv.isPagingEnabled = false
		cv.focusGroupIdentifier = "infoCollectionView"
        cv.backgroundColor = .sunset.withAlphaComponent(0.3)
		return cv
	}()
    
    lazy var bgImage: UIImageView = {
        let image = UIImageView(image: UIImage(resource: .bg))
        image.alpha = 0.7
        return image
    }()
    
    // lower collection
	lazy private var pageControlCollectionView: UICollectionView = {
		// FlowLayout setup
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
		
		let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
		cv.delegate = self
		cv.dataSource = self
		cv.focusGroupIdentifier = "viewsCollectionView"
		cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .init(white: 1, alpha: 0.0)

		return cv
	}()
	
    // page control
    private var pageControl: UIPageControl!
    
	override func setupViews(){

        setupPageControl()
        contentView.addSubview(bgImage)
		contentView.addSubview(customView)
        contentView.addSubview(collectionsStackView)
		contentView.addSubview(pageControl)
        contentView.bringSubviewToFront(pageControl)
        collectionsStackView.addArrangedSubview(conditionsCollectionViewWithTwoSections)
		collectionsStackView.addArrangedSubview(pageControlCollectionView)
        
        conditionsCollectionViewWithTwoSections.register(
            CurrentConditionsCollectionViewCell.self,
            forCellWithReuseIdentifier: CurrentConditionsCollectionViewCell.identifier
        )
        let nib = UINib(nibName: "NextHourCollectionViewCell", bundle: nil)
        conditionsCollectionViewWithTwoSections.register(
            nib,
            forCellWithReuseIdentifier: "NextHourCollectionViewCell"
        )
		
        //‼️ new cell to be created
        pageControlCollectionView.register(
            PageControlCollectionViewCell.self,
            forCellWithReuseIdentifier: PageControlCollectionViewCell.identifier
        )

        // header cell +26
		customView.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.greaterThanOrEqualTo(20)
            make.bottom.equalTo(collectionsStackView.snp.top).inset(-35)
		}
        
        // collectionView cells setup
        collectionsStackView.snp.makeConstraints { make in
            make.top.equalTo(customView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview()
        }
        
        conditionsCollectionViewWithTwoSections.snp.makeConstraints({
            $0.height.equalTo(100)
        })
		
		pageControl.snp.makeConstraints({
			$0.top.equalTo(collectionsStackView.snp.bottom)
			$0.centerX.bottom.equalToSuperview()
		})
        
        bgImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(pageControlCollectionView.snp.centerY)
            make.height.equalTo(450)
        }
    
		
	}
	// MARK: - page control setup
	private func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        pageControl.currentPage = 0
        pageControl.numberOfPages = dataStore.pageControlMockData.count
		pageControl.translatesAutoresizingMaskIntoConstraints = false
		pageControl.currentPageIndicatorTintColor = UIColor.black
		pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        pageControl.frame = contentView.frame
        pageControl.backgroundColor = UIColor(white: 1, alpha: 0.5)
        pageControl.addTarget(self, action: #selector(self.pageControlSelectionAction(_:)), for: .valueChanged)
	}

    
    func fill(_ fact: Fact, forecast: ForecastResponse){
        customView.fill(fact)
    
        dataStore.forecast = forecast
        // MARK: - я этих часов мамы рот ебал
        conditionsCollectionViewWithTwoSections.reloadData()
        currentHourChecker()
    }
}

// MARK: - UICollectionView DataSource
extension HeaderTableViewCell: UICollectionViewDataSource {
	// MARK: - focus group policy
	func numberOfSections(in collectionView: UICollectionView) -> Int {
        // ‼️ safety unwrap needed
		switch CVFocus(rawValue: collectionView.focusGroupIdentifier ?? "")! {
		case .conditionsCellsWithTwoSections:
			return CVSections.allCases.count
		case .pageControlCells:
			return 1
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// ‼️ safety unwrap needed
		switch CVFocus(rawValue: collectionView.focusGroupIdentifier ?? "")! {
			
		case .conditionsCellsWithTwoSections:
            return CVSections(rawValue: section) == .conditions ? 1 : (dataStore.forecast?.forecast.forecastday.first?.hour.count ?? 0)

		case .pageControlCells:
            return dataStore.pageControlMockData.count
		}
       
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // MARK: - Getting focus group
		guard let focus = CVFocus(rawValue: collectionView.focusGroupIdentifier ?? "") else { fatalError("Invalid section") }
		// MARK: - separation according focusGruop policy
		switch focus {
            // MARK: - head section with current conditions & next hours conditions
		case .conditionsCellsWithTwoSections:
			guard let cvSection = CVSections(rawValue: indexPath.section) else { fatalError("Invalid section") }
			switch cvSection {
			case .conditions:
				guard let conditionsCell = collectionView.dequeueReusableCell(
					withReuseIdentifier: CurrentConditionsCollectionViewCell.identifier,
					for: indexPath
				) as? CurrentConditionsCollectionViewCell else { fatalError("falied to dequeue CurrentConditionsCollectionViewCell") }
                
                
                conditionsCell.conditions = dataStore.forecast?.current
                
				return conditionsCell
            
			case .nextHours:
				guard let nextHoursCell = collectionView.dequeueReusableCell(
					withReuseIdentifier: NextHourCollectionViewCell.identifier,
					for: indexPath
				) as? NextHourCollectionViewCell else { fatalError("falied to dequeue NextHoursForecastCollectionViewCell") }
                nextHoursCell.backgroundColor = .sunset.withAlphaComponent(0.1)
                
                nextHoursCell.hourlyCondition = dataStore.forecast?.forecast.forecastday.first?.hour[indexPath.row]
                
                
				return nextHoursCell
			}
			// MARK: - separation to wide cells section based on focusGroup policy
		case .pageControlCells:
            guard let pageControlCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: PageControlCollectionViewCell.identifier,
                for: indexPath
            ) as? PageControlCollectionViewCell else { fatalError("falied to dequeue NextHoursForecastCollectionViewCell") }
            pageControlCell.textlabel.text = String(indexPath.row)
            pageControlCell.backgroundColor = .init(white: 1, alpha: 0.0)
            return pageControlCell
		}
	}
}

// MARK: - UICollectionView Delegate & DelegateFlowLayout
extension HeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CVFocus(
            rawValue: collectionView.focusGroupIdentifier ?? ""
        ) == .conditionsCellsWithTwoSections ? CGSize.init(
            width: 80,
            height: collectionView.frame.height
        ) :  CGSize.init(
            width: contentView.frame.width,
            height: collectionView.frame.height
        )
    }
    
    // vertical spacing
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    // horizontal spacing
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt section: Int
    ) -> CGFloat {
        return 0
    }
    // spacing between sections
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return CVFocus(
            rawValue: collectionView.focusGroupIdentifier ?? ""
        ) == .conditionsCellsWithTwoSections ? UIEdgeInsets(
            top: 0,
            left: 5,
            bottom: 0,
            right: 3
        ) :  UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let focusGroup = CVFocus(rawValue: collectionView.focusGroupIdentifier ?? "") else { fatalError("invalid section") }
        
        switch focusGroup {
        case .conditionsCellsWithTwoSections:
            break
        case .pageControlCells:
            let mapViewController = MapViewController()
            if let parentVC = parentViewController {
                parentVC.navigationController?.pushViewController(mapViewController, animated: true)
                // MARK: - additional settings that affects on mapVC
                parentVC.navigationController?.navigationBar.isHidden = false
                parentVC.navigationController?.navigationBar.prefersLargeTitles = false
            }
        }
    }
    
    // MARK: - pageControl condition to react only on pageControlCollectionView actions
    func scrollViewDidEndDecelerating(
        _ scrollView: UIScrollView
    ) {
        if scrollView == pageControlCollectionView {
            pageControl.currentPage = Int(
                scrollView.contentOffset.x
            ) / Int(
                scrollView.frame.width
            )
        }
    }
    
    @objc func pageControlSelectionAction(
        _ sender: UIPageControl
    ) {
        pageControlCollectionView.scrollToItem(
            at: IndexPath(
                item: sender.currentPage,
                section: 0
            )
            ,
            at: .centeredHorizontally,
            animated: true
        )
    }
    
    func currentHourChecker() {
        guard let hours = dataStore.forecast?.forecast.forecastday.first?.hour else { return }
        var count = 0
        
        hours.forEach({hour in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
            
            if let date = dateFormatter.date(from: hour.time) {
                let calendar = Calendar.current
                let components = calendar.dateComponents([.hour, .minute], from: date)
                count += 1
                if calendar.dateComponents( [.hour], from: Date()).hour == components.hour {
                    self.conditionsCollectionViewWithTwoSections.scrollToItem(at: IndexPath(row: count, section: 1), at: .left, animated: true)
                }
                
            }
        })
    }
}

extension HeaderTableViewCell {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            if let viewController = responder as? UIViewController {
                return viewController
            }
            parentResponder = responder.next
        }
        return nil
    }
}
