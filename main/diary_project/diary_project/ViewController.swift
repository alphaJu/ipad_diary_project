//
//  ViewController.swift
//  diary_project
//
//  Created by yeon suk choi on 2018. 8. 19..
//  Copyright © 2018년 woongs. All rights reserved.
//

import UIKit
import JTAppleCalendar  

class ViewController: UIViewController {
    let formatter = DateFormatter()
    @IBOutlet var collectionView: JTAppleCalendarView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    //display the cell
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let mycell = cell as! CustomCell
        mycell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let mycell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        mycell.dateLabel.text = cellState.text
        
        self.calendar(calendar, willDisplay: mycell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return mycell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat="yyyy MM dd"
        formatter.timeZone=Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2019 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}




