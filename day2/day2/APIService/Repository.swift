//
//  Repository.swift
//  day2
//
//  Created by ATM Touchpoint on 19/10/23.
//

import Foundation
import UIKit
import CoreData

class Repository: NSObject {
    
    func getManualEmployees(
        onSuccess: @escaping ([ManualEmployeeData]) -> Void,
        onError: @escaping (Error?) -> Void
    ){
        var employees = [ManualEmployeeData]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
        
        do{
            let result = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            
            employees = result.map{employee in
                return ManualEmployeeData(id: employee.value(forKey: "id") as! Int, name: employee.value(forKey: "name") as! String, salary: employee.value(forKey: "salary") as! String)
            }
            
            onSuccess(employees)
            
        }catch let err {
            onError(err)
            
        }
    }
    
    func updateManualEmployee(
        oldEmployee: ManualEmployeeData,
        newEmployee: ManualEmployeeData,
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error?) -> Void
    ){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
        //        fetchRequest.predicate = NSPredicate(format: "id = %@ && name = %@", [String(oldEmployee.id), oldEmployee.name])
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManualEmployee")
        fetchRequest.predicate = NSPredicate(format: "id = %@", String(oldEmployee.id))
        
        do{
            let fetch = try managedContext.fetch(fetchRequest)
            let dataToUpdate = fetch[0] as! NSManagedObject
            dataToUpdate.setValue(newEmployee.id, forKey: "id")
            dataToUpdate.setValue(newEmployee.name, forKey: "name")
            dataToUpdate.setValue(newEmployee.salary, forKey: "salary")
            
            try managedContext.save()
            onSuccess()
        }catch let err{
            onError(err)
        }
    }
    
    func createManualEmployee(
        id: Int,
        name: String,
        salary: String,
        onSuccess: @escaping () -> Void){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let manualEmployeeEntity = NSEntityDescription.entity(forEntityName: "ManualEmployee", in: managedContext)
            
            let insert = NSManagedObject(entity: manualEmployeeEntity!, insertInto: managedContext)
            insert.setValue(id, forKey: "id")
            insert.setValue(name, forKey: "name")
            insert.setValue(salary, forKey: "salary")
            
            appDelegate.saveContext()
            onSuccess()
        }
    
    func deleteManualEmployee(
        id: Int,
        onSuccess: @escaping () -> Void,
        onError: @escaping (Error?) -> Void){
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "ManualEmployee")
            fetchRequest.predicate = NSPredicate(format: "id = %@", String(id))
            
            do{
                let dataToDelete = try managedContext.fetch(fetchRequest)[0] as! NSManagedObject
                managedContext.delete(dataToDelete)
                
                try managedContext.save()
                onSuccess()
            }catch let err{
                onError(err)
            }
        }
}
