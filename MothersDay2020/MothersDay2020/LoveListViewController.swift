//
//  LoveListViewController.swift
//  MothersDay2020
//
//  Created by Jameson Rader on 5/7/20.
//  Copyright © 2020 Rader Enterprises. All rights reserved.
//

import UIKit

class LoveListViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var reasonLabel: UILabel!
    var index = 0
    var now = Date.init()

    public init() {
        super.init(nibName: "LoveListViewController", bundle: .main)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = false
        self.title = "<3"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNextBarButtonItem()

        // Show todays date
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        let dateString = dateFormatterPrint.string(from: now)
        dateLabel.text = dateString
        
        // Get day of year
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: now)
        index = day! % Reasons.reasons.count
        setReason(index: index)
    }
    
    func setNextBarButtonItem() {
        let logoutBarButtonItem = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(goToNextReason))
        self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
    }

    func setReason(index: Int) {
        reasonLabel.text = Reasons.reasons[index]
    }
    
    @objc func goToNextReason() {
        
        // Show todays date
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd, yyyy"
        
        let futureNow = NSCalendar.current.date(byAdding: .day, value: 1, to: now)
        now = futureNow!
        
        let dateString = dateFormatterPrint.string(from: futureNow!)
        dateLabel.text = dateString
        
        // Get day of year
        let cal = Calendar.current
        let day = cal.ordinality(of: .day, in: .year, for: now)
        index = day! % Reasons.reasons.count
        setReason(index: index)
        
        index = index + 1
        if index > (Reasons.reasons.count - 1) {
            index = 0
        }
        setReason(index: index)
    }
    
}
