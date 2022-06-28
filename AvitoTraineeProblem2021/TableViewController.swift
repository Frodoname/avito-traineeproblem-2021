//
//  ViewController.swift
//  AvitoTraineeProblem2021
//
//  Created by Fed on 27.06.2022.
//

import UIKit



class TableViewController: UITableViewController {
    
    var netWork = NetworkManager()
    
    var countCells: Int?
    var error: Error?
    var data: NetworkData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        netWork.delegate = self
        netWork.fetchData()

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Avito Job Candidates"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countCells ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellInfo", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        if let gotData = data?.company.employees[indexPath.row] {
            content.text = "Имя кандидата: \(gotData.name) \nТелефон кандидата: \(gotData.phone_number) \nЯзыки программирования: \(gotData.skills.shuffled().joined(separator: ", "))"
        }
        cell.contentConfiguration = content
        return cell
    }
}
//MARK: - TableViewDelegate

extension TableViewController: NetworkDelegate {
    
    func loadData(dataResultsLoaded: NetworkData) {
        DispatchQueue.main.async {
            self.data = dataResultsLoaded
            self.countCells = dataResultsLoaded.company.employees.count
            self.tableView.reloadData()
        }
    }
    
    func errorWarning(with: Error) {
        print(with.localizedDescription)
    }
}
