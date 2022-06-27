//
//  ViewController.swift
//  AvitoTraineeProblem2021
//
//  Created by Fed on 27.06.2022.
//

import UIKit



class TableViewController: UITableViewController {
    
    var netWork = NetworkManager()
    
    var count: Int?
    var error: Error?
    
    var testData: NetworkData?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        netWork.delegate = self
        netWork.fetchData()

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Avito Job Candidates"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath)
        var content = cell.defaultContentConfiguration()
        if let one = testData?.company.employees[indexPath.row] {
            content.text = "Имя кандидата: \(one.name) \nТелефон кандидата: \(one.phone_number) \nЯзыки программирования: \(one.skills.shuffled().joined(separator: ", "))"
        }
        cell.contentConfiguration = content
        return cell
    }
}

extension TableViewController: NetworkDelegate {
    
    func loadData(dataResultsLoaded: NetworkData) {
        
        DispatchQueue.main.async {
            
            self.testData = dataResultsLoaded
            self.count = dataResultsLoaded.company.employees.count
            self.tableView.reloadData()
        }
       
        
    }
    
    func errorWarning(with: Error) {
        print("HREN")
        print(with.localizedDescription)
    }
    
    
}
