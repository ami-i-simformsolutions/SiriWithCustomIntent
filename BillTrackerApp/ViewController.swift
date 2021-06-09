//
//  ViewController.swift
//  BillTrackerApp
//
//  Created by Ami Intwala on 26/05/21.
//

import UIKit

class ViewController: UIViewController {

    var billList: [[String: Any]] = []
    @IBOutlet weak var tblView: UITableView!
    let userDefaults = UserDefaults(suiteName: "group.com.simform.temp")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let billList = userDefaults.array(forKey: "BillData") as? [[String: Any]] {
            self.billList = billList
            self.tblView.reloadData()
        }
    }
    
    @IBAction func AddBillButtonTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddBillController") as! AddBillController
        vc.modalPresentationStyle = .overFullScreen
        vc.completion = { success in
            if let billList = self.userDefaults.array(forKey: "BillData") as? [[String: Any]] {
                self.billList = billList
                self.tblView.reloadData()
            }
        }
        present(vc, animated: true, completion: nil)
    }
}

//MARK:- UITableView Delegate and DataSource -

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? UITableViewCell else {
            return UITableViewCell()
        }
        let bill = billList[indexPath.row]
        cell.textLabel?.text = bill["title"] as? String
        cell.detailTextLabel?.text = (bill["price"] as? Int)?.description
        return cell
    }
}
