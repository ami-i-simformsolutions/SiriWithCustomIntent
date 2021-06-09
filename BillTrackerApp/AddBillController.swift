//
//  AddBillController.swift
//  BillTrackerApp
//
//  Created by Ami Intwala on 01/06/21.
//

import UIKit

class AddBillController: UIViewController {

    @IBOutlet weak var txtBillName: UITextField!
    @IBOutlet weak var txtBillPrice: UITextField!
    var completion: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addBillButtonTapped(_ sender: Any) {
        var data = [[String: Any]]()
        data.append(["title": txtBillName.text ?? "", "price": Int(txtBillPrice.text ?? "") ?? 0 ])
        guard let userDefaults = UserDefaults(suiteName: "group.com.simform.temp") else { return }
        if let billData = userDefaults.array(forKey: "BillData") as? [[String: Any]] {
            data.append(contentsOf: billData)
            userDefaults.setValue(data, forKey: "BillData")
        } else {
            userDefaults.setValue(data, forKey: "BillData")
        }
        self.dismiss(animated: true, completion: nil)
        completion?(true)
    }
}
