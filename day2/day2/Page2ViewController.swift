//
//  Page2ViewController.swift
//  day2
//
//  Created by ATM Touchpoint on 13/10/23.
//

import UIKit


class Page2ViewController: UIViewController {

    private let profileCell = "ProfileCell"
    @IBOutlet weak var helloLabel: UILabel!
    
    var name: String = "Christian"
    
    @IBOutlet weak var profileTableView: UITableView!
    
    let dataProfile = Profile(
        name: "Christian",
        job: "HepiHepi",
        age: 25,
        bio: "Project ini adalah project gabungan dari day1 sampai dayX"
    )
    
    let profileTypeOrder = [
        ProfileType.name,
        ProfileType.job,
        ProfileType.age,
        ProfileType.bio
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register cellnya ke tableviewnya, nibname = nama classnya, reuseidentifier = identifiernya
        profileTableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: profileCell)
        
        //alternatif drag 2 titik di storyboard
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        //row height setup
        profileTableView.rowHeight = UITableView.automaticDimension
        profileTableView.estimatedRowHeight = 400
        
        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "masukSegue"{
            let destination = segue.destination as! ViewController
            destination.dName = name
        }
    }
    
    
    @IBAction func masukClick(_ sender: Any) {
        performSegue(withIdentifier: "masukSegue", sender: nil)
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

extension Page2ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: profileCell, for: indexPath) as! ProfileTableViewCell
        
        let cellData: [(ProfileType, String)] = [
            (profileTypeOrder[0], dataProfile.name),
            (profileTypeOrder[1], dataProfile.job),
            (profileTypeOrder[2], String(dataProfile.age)),
            (profileTypeOrder[3], dataProfile.bio),
        ]
        
        cell.setValue(type: cellData[indexPath.row].0, value: cellData[indexPath.row].1)
        
        return cell
    }
    
    
    //manual row height
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
}
