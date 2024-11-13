//
//  DetailViewController.swift
//  Lessons-59
//
//  Created by Serhii Prysiazhnyi on 13.11.2024.
//

import UIKit

class DetailViewController: UITableViewController {
    
    // Переменная для выбранной страны
       var selectedCountry: Country?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
print("Detail --- \(selectedCountry)")
        
    }
    


}
