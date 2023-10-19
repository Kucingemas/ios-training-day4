//
//  EmployeeTableViewCell.swift
//  day2
//
//  Created by ATM Touchpoint on 18/10/23.
//

import UIKit

class EmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var gajiLabel: UILabel!
    @IBOutlet weak var umurLabel: UILabel!
    @IBOutlet weak var namaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataEmployee (employee: Employee){
        namaLabel.text = ": \(employee.employeeName)"
        umurLabel.text = ": \(String(employee.employeeAge))"
        gajiLabel.text = ": Rp \(String(employee.employeeSalary))"
    }
    
}
