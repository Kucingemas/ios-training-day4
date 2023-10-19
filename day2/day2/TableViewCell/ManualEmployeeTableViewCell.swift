//
//  ManualEmployeeTableViewCell.swift
//  day2
//
//  Created by ATM Touchpoint on 19/10/23.
//

import UIKit

class ManualEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var manualEmployeeLabel: UILabel!
    @IBOutlet weak var manualEmployeeSalaryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setManualEmployee (employee: ManualEmployeeData){
        manualEmployeeLabel.text = "\(employee.id). \(employee.name)"
        manualEmployeeSalaryLabel.text = "Rp. \(employee.salary)"
    }
    
}
