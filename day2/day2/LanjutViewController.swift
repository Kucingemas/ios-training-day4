//
//  LanjutViewController.swift
//  day2
//
//  Created by ATM Touchpoint on 19/10/23.
//

import UIKit
import CoreData

class LanjutViewController: UIViewController {
    
    var viewModel: ManualEmployeeViewModel!
    
    private let mEmployeeCell = "ManualEmployeeCell"
    @IBOutlet weak var manualEmployeeTableView: UITableView!
    
    @IBAction func addEmployeeAction(_ sender: Any) {
        let alert = UIAlertController(title: "tambah budak", message: "ayo tambahkan budak disini!", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {tf in tf.placeholder = "id"})
        
        alert.addTextField(configurationHandler: {tf in tf.placeholder = "nama"})
        
        alert.addTextField(configurationHandler: {tf in
            tf.placeholder = "gaji"
            tf.textContentType = .telephoneNumber
        })
        
        alert.addAction(UIAlertAction(title: "Tambah", style: .default, handler: {
            action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty || alert.textFields![2].text!.isEmpty{
                let warning = UIAlertController(title: "Warning", message: "Masukin semua woe!", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
                
                self.present(warning, animated: true)
            } else {
                self.viewModel.createData(id: Int(alert.textFields![0].text!) ?? 0 , name: alert.textFields![1].text!, salary: alert.textFields![2].text!)
                
                let success = UIAlertController(title: "Sukses", message: "Data budak berhasil ditambah", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
                
                self.present(success, animated: true)
                
            }
        }))
        self.present(alert, animated: true)
    }
    
    
    //old crud function
//    func createEmployee(id: Int, name: String, salary: String){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let manualEmployeeEntity = NSEntityDescription.entity(forEntityName: "ManualEmployee", in: managedContext)
//
//        let insert = NSManagedObject(entity: manualEmployeeEntity!, insertInto: managedContext)
//        insert.setValue(id, forKey: "id")
//        insert.setValue(name, forKey: "name")
//        insert.setValue(salary, forKey: "salary")
//
//        appDelegate.saveContext()
//    }
//
//    func updateEmployee(oldEmployee: ManualEmployeeData, newEmployee: ManualEmployeeData) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
//        //        fetchRequest.predicate = NSPredicate(format: "id = %@ && name = %@", [String(oldEmployee.id), oldEmployee.name])
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
//        fetchRequest.predicate = NSPredicate(format: "id = %@", String(oldEmployee.id))
//
//        do{
//            let fetch = try managedContext.fetch(fetchRequest)
//            let dataToUpdate = fetch[0] as! NSManagedObject
//            dataToUpdate.setValue(newEmployee.id, forKey: "id")
//            dataToUpdate.setValue(newEmployee.name, forKey: "name")
//            dataToUpdate.setValue(newEmployee.salary, forKey: "salary")
//
//            try managedContext.save()
//        }catch let err{
//            print("ERROR", err)
//        }
//
//    }
//
//    func deleteEmployee(_ id: Int){
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ManualEmployee")
//        fetchRequest.predicate = NSPredicate(format: "id = %@", String(id))
//
//        do{
//            let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
//            managedContext.delete(dataToDelete)
//
//            try managedContext.save()
//        }catch let err{
//            print(err)
//        }
//    }
//
//    func getEmployee() -> [ManualEmployeeData]{
//        var employees = [ManualEmployeeData]()
//
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//
//        let managedContext = appDelegate.persistentContainer.viewContext
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
//
//        do{
//            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
//
//            employees = result.map{employee in
//                return ManualEmployeeData(id: employee.value(forKey: "id") as! Int, name: employee.value(forKey: "name") as! String, salary: employee.value(forKey: "salary") as! String)
//            }
//        }catch let err {
//            print("ERROR", err)
//        }
//
//        return employees
//    }
    
    func editEmployeeAction(employee: ManualEmployeeData){
        let alert = UIAlertController(title: "edit budak", message: "ayo edit budak disini!", preferredStyle: .alert)
        
        alert.addTextField(configurationHandler: {tf in
            tf.text = String(employee.id)
            tf.isEnabled=false})
        
        alert.addTextField(configurationHandler: {tf in tf.text = employee.name})
        
        alert.addTextField(configurationHandler: {tf in
            tf.text = employee.salary
            tf.textContentType = .telephoneNumber
        })
        
        alert.addAction(UIAlertAction(title: "Edit", style: .default, handler: {
            action in
            if alert.textFields![0].text!.isEmpty || alert.textFields![1].text!.isEmpty{
                let warning = UIAlertController(title: "Warning", message: "Masukin semua woe!", preferredStyle: .alert)
                warning.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
                
                self.present(warning, animated: true)
            } else {
                //                self.createEmployee(id: Int(alert.textFields![0].text!) ?? 0 , name: alert.textFields![1].text!)
                self.viewModel.editData(oldEmployee: employee, newEmployee: ManualEmployeeData(id: Int(alert.textFields![0].text!) ?? 0, name: alert.textFields![1].text!, salary: alert.textFields![2].text!))
                
                
                let success = UIAlertController(title: "Sukses", message: "Data budak berhasil diubah", preferredStyle: .alert)
                success.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
                
                self.present(success, animated: true)
                
            }
        }))
        self.present(alert, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //register cellnya ke tableviewnya, nibname = nama classnya, reuseidentifier = identifiernya
        manualEmployeeTableView.register(UINib(nibName: "ManualEmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: mEmployeeCell)
        
        //alternatif drag 2 titik di storyboard
        manualEmployeeTableView.dataSource = self
        manualEmployeeTableView.delegate = self
        
        //row height setup
        manualEmployeeTableView.rowHeight = UITableView.automaticDimension
        manualEmployeeTableView.estimatedRowHeight = 400
        
        viewModel = ManualEmployeeViewModel()
        viewModel.bindDataToVC = {
            self.manualEmployeeTableView.reloadData()
        }
        
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

extension LanjutViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: mEmployeeCell, for: indexPath) as! ManualEmployeeTableViewCell
        
        let cellData : [ManualEmployeeData] = viewModel.employeeData
        
        cell.setManualEmployee(employee: cellData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editEmployeeAction(employee: viewModel.employeeData[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.viewModel.deleteData(id: viewModel.employeeData[indexPath.row].id)
        }
    }
    
}
