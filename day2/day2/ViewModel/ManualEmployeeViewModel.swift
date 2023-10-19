//
//  ManualEmployeeViewModel.swift
//  day2
//
//  Created by ATM Touchpoint on 19/10/23.
//

import Foundation

class ManualEmployeeViewModel: NSObject{
    private var repository: Repository!
    
    private(set) var employeeData: [ManualEmployeeData] = []{
        didSet{
            self.bindDataToVC()
        }
    }
    
    var bindDataToVC: () -> () = {}
    
    override init() {
        super.init()
        repository = Repository()
    }
    
    func getData(){
        repository.getManualEmployees(onSuccess: {
            employees in self.employeeData = employees
        }, onError: { error in print(error ?? "")})
    }
    
    func editData(oldEmployee: ManualEmployeeData, newEmployee: ManualEmployeeData){
        repository.updateManualEmployee(oldEmployee: oldEmployee, newEmployee: newEmployee, onSuccess: {
            self.getData()
        }, onError: {error in print(error ?? "")})
    }
    
    func createData( id: Int,
                     name: String,
                     salary: String){
        repository.createManualEmployee(id: id, name: name, salary: salary, onSuccess: {
            self.getData()
        })
    }
    
    func deleteData(id: Int){
        repository.deleteManualEmployee(id: id, onSuccess: {
            self.getData()
        }, onError:  {error in print(error ?? "")})
    }
    
}
