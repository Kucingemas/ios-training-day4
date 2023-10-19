//
//  ViewController.swift
//  day2
//
//  Created by ATM Touchpoint on 13/10/23.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    private let employeeCell = "EmployeeCell"
    
    var employees : [Employee] = []
    
    @IBOutlet weak var employeeTableView: UITableView!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    var dName : String = ""
    
    var viewModel: EmployeeViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        welcomeLabel.text = "Welcome,\n \(dName)"
        
        //register cellnya ke tableviewnya, nibname = nama classnya, reuseidentifier = identifiernya
        employeeTableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: employeeCell)
        
        //alternatif drag 2 titik di storyboard
        employeeTableView.dataSource = self
        employeeTableView.delegate = self
        
        //row height setup
        employeeTableView.rowHeight = UITableView.automaticDimension
        employeeTableView.estimatedRowHeight = 400
        
        viewModel = EmployeeViewModel()
        viewModel.bindDataToVC = {
            self.employeeTableView.reloadData()
        }
//        viewModel.fetchData()
//        getEmployees()
    }
    
    func getEmployees(){
        guard let url = URL(string: "https://dummy.restapiexample.com/api/v1/employees") else {return}
        let urlConv :URLConvertible = url
        
        AF.request(urlConv).response { responseData in
                do{
                    let result = try JSONDecoder().decode(EmpployeeData.self, from: responseData.data!)
                    
                    DispatchQueue.main.async { [weak self] in
                        self?.employees = result.data
                        self?.employeeTableView.reloadData()
                    }
        
                }catch let jsonErr{
                    print("ERROR GET EMPLOYEE", jsonErr)
                }
            }
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: employeeCell, for: indexPath) as! EmployeeTableViewCell
        
        let cellData = viewModel.employeeData
        
        cell.setDataEmployee(employee: cellData[indexPath.row])
        
        return cell
    }
    
    
}

