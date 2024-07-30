//
//  HomeCarouselRow.swift
//  WeatherApp
//
//  Created by SOOPIN KIM on 2024-07-27.
//

import UIKit

class HomeCarouselRow: UITableViewCell {
    static let id = "HomeCarouselRow"
    private var list: [WeeklyForecastList] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func setupCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configure(_ forecase: WeeklyForecast?){
        guard let list = forecase?.list else { return }
        self.list = list
        collectionView.reloadData()
    }

}

extension HomeCarouselRow: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        print(list.count)
        return list.count > 8 ? 8 : list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DailyForecastCell.id, for: indexPath) as! DailyForecastCell
        let item = list[indexPath.item]
        cell.configure(item)
        
        return cell
    }
}

extension HomeCarouselRow: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 140)
    }
}
