//
//  CalendarViewController.swift
//  PostOfTheDay
//
//  Created by Ryan Dennis on 11/29/19.
//  Copyright © 2019 Ryan Dennis. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {
    
    var calendarTable: UICollectionView!
    var days: [Post]!
    
    let dayCellReuseIdentifier = "dayCellReuseIdentifier"
    let headerReuseIdentifier = "headerReuseIdentifier"
    let padding: CGFloat = 8
    let headerHeight: CGFloat = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendarLayout = UICollectionViewFlowLayout()
        calendarLayout.scrollDirection = .vertical
        calendarLayout.minimumLineSpacing = padding
        calendarLayout.minimumInteritemSpacing = padding
        
//        let testPost = Post(body_post: "testing test test test test test", upvotes: 25)
//
//        days = [Post(body_post: "This is a really long test to make sure that the text will properly wrap to the next line in each day view cell.", upvotes: 130), testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost, testPost]
        days = []

        calendarTable = UICollectionView(frame: .zero, collectionViewLayout: calendarLayout)
        calendarTable.backgroundColor = .white
        view.addSubview(calendarTable)
        
        calendarTable.register(DayCollectionViewCell.self, forCellWithReuseIdentifier: dayCellReuseIdentifier)
        calendarTable.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier)
        calendarTable.dataSource = self
        calendarTable.delegate = self
        
        
        setupConstraints()
        loadPosts()
    }
    
    func loadPosts() {
        NetworkManager.getTopPosts { (got_posts) in
            self.days = got_posts
            DispatchQueue.main.async {
                self.calendarTable.reloadData()
            }
        }
    }
    func setupConstraints() {
        calendarTable.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension CalendarViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: dayCellReuseIdentifier, for: indexPath) as! DayCollectionViewCell

        cell.configure(for: days[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath) as! HeaderView
        return header
    }
}

extension CalendarViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // CELL padding CELL padding CELL = width
        let size = (collectionView.frame.width - padding * 2)
        return CGSize(width: size, height: size/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: headerHeight)
    }
}

extension CalendarViewController: UICollectionViewDelegate {
    
}
