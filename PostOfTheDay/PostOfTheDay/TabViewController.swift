//
//  TabViewController.swift
//  PostOfTheDay
//
//  Created by Aidan Hobler on 11/21/19.
//  Copyright © 2019 Aidan Hobler. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    var today: TodayView?
    var calendar: CalendarView?
    var tItem: UITabBarItem?
    var cItem: UITabBarItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        today = TodayView()
        calendar = CalendarView()
        
        tItem = UITabBarItem()
        tItem?.title = "Today"
        
        cItem = UITabBarItem()
        cItem?.title = "Calendar"
        
        today?.tabBarItem = tItem
        calendar?.tabBarItem = cItem
        
        //self.viewControllers = [today!, calendar!]
        viewControllers = [ViewController(), ViewController()]

        // Do any additional setup after loading the view.
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
