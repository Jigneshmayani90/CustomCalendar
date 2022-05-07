//
//  ViewController.swift
//  RRCustomCalendar
//
//  Created by Rahul on 07/05/22.
//

import UIKit

struct CalData {
    var day: String
    var date: Date?
    var data: Any?
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource
{
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedDate = Date()
    var totalSquares = [CalData]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setCellsView()
        setMonthView()
    }
    
    func setCellsView()
    {
        let width = (collectionView.frame.size.width - 2) / 7
        let height = (collectionView.frame.size.height - 2) / 7
        
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setMonthView()
    {
        totalSquares.removeAll()
        
        let daysInMonth = selectedDate.daysInMonth
        let firstDayOfMonth = selectedDate.firstOfMonth
        let startingSpaces = firstDayOfMonth.weekDay
        
        var count: Int = 1
        
        let monthYear = selectedDate.monthString + " " + selectedDate.yearString
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth)
            {
                totalSquares.append(CalData(day: ""))
            }
            else
            {
                let day = String(count - startingSpaces)
                let strDate = day + " " + monthYear
                totalSquares.append(CalData(day: day, date: strDate.date))
            }
            count += 1
        }
        
        monthLabel.text = selectedDate.monthString + " " + selectedDate.yearString
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "calCell", for: indexPath) as! CalendarCell
        
        let data = totalSquares[indexPath.item]
        cell.dayOfMonth.text = data.day
        if let date = data.date, Calendar.current.isDateInToday(date) {
            cell.dayOfMonth.textColor = .blue
        } else {
            cell.dayOfMonth.textColor = .black
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let data = totalSquares[indexPath.item]
        guard let date = data.date else { return }
        print(date.dayString)
    }
    
    @IBAction func previousMonth(_ sender: Any)
    {
        selectedDate = selectedDate.minusMonth
        setMonthView()
    }
    
    @IBAction func nextMonth(_ sender: Any)
    {
        selectedDate = selectedDate.plusMonth
        setMonthView()
    }
    
    override open var shouldAutorotate: Bool
    {
        return false
    }
}

