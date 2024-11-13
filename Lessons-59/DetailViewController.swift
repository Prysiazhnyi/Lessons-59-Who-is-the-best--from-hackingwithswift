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
    var countryDetails = [String]() // Массив для хранения информации о стране
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedCountry?.nameCountry ?? "Помилка"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        // Проверяем, есть ли выбранная страна и наполняем массив countryDetails
        if let country = selectedCountry {
            countryDetails.append("Країна: \(country.nameCountry)")
            countryDetails.append("Столиця країни: \(country.capitalCountry)")
            countryDetails.append("Населення: \(country.populationCountry) чол.")
            countryDetails.append("Опис: \(country.description)")
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryDetails.count // Возвращаем количество элементов в массиве countryDetails
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Details", for: indexPath)
        
        // Получаем строку для текущей ячейки
        let text = countryDetails[indexPath.row]
        
        // Создаем NSMutableAttributedString для работы с атрибутами
        let attributedText = NSMutableAttributedString(string: text)
        
        // Список слов-заголовков для выделения жирным
        let boldParts = ["Країна:", "Столиця країни:", "Населення:", "Опис:"]
        
        // Применяем жирный шрифт к каждому заголовку
        boldParts.forEach { part in
            let range = (text as NSString).range(of: part)
            if range.location != NSNotFound {
                attributedText.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 18), range: range)
            }
        }
        
        // Устанавливаем атрибутированный текст в ячейку
        cell.textLabel?.attributedText = attributedText
        
        // Настройка для переноса текста и увеличения числа строк
        cell.textLabel?.numberOfLines = 0  // Позволяет неограниченное количество строк
        cell.textLabel?.lineBreakMode = .byWordWrapping  // Перенос текста по словам
        
        return cell
    }
    
    @objc func shareTapped() {
        guard let country = selectedCountry else {
            print("Country data not found")
            return
        }
        
        // Собираем детали страны в одну строку
        let countryDetails = """
        Країна: \(country.nameCountry)
        Столиця країни: \(country.capitalCountry)
        Населення: \(country.populationCountry) чол.
        Опис: \(country.description)
        """
        
        // Передаем текстовые данные в UIActivityViewController
        let itemsToShare: [Any] = [countryDetails]
        let vc = UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
        
        // Настройка popover для iPad, чтобы избежать ошибок на iPad
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        // Открываем UIActivityViewController
        present(vc, animated: true)
    }
    
}

