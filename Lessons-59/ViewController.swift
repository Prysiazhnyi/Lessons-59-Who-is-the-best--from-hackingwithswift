//
//  ViewController.swift
//  Lessons-59
//
//  Created by Serhii Prysiazhnyi on 13.11.2024.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Рейтинг топ 20 країн для життя"
        
        loadLocalJSON()
    }
    
    
    func loadLocalJSON() {
         DispatchQueue.global().async {
             // Получаем путь к файлу в bundle приложения
             if let url = Bundle.main.url(forResource: "Countries", withExtension: "json") {
                 
                 do {
                     // Читаем данные из файла
                     let data = try Data(contentsOf: url)
                     
                     // Декодируем данные в массив объектов
                     let decoder = JSONDecoder()
                     let countries = try decoder.decode([Country].self, from: data)
                     
                     // Печатаем загруженные данные в консоль
                     print("Loaded items: \(countries[0])")
                     
                     // Переходим на главный поток для обновления UI
                     DispatchQueue.main.async {
                         self.countries = countries
                         self.tableView.reloadData()
                     }
                     
                 } catch {
                     // Обработка ошибок
                     print("Error loading or decoding JSON: \(error)")
                 }
                 
             }
         }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Countries", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = country.nameCountry
        cell.detailTextLabel?.text = country.capitalCountry
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Увеличиваем счетчик просмотров для выбранного изображения
        //countries[indexPath.row].viewCount += 1
        print(countries[indexPath.row])
        tableView.reloadData()
    
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            //
            vc.selectedCountry = countries[indexPath.row]
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

