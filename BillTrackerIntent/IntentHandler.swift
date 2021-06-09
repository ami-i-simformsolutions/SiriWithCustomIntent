//
//  IntentHandler.swift
//  BillTrackerIntent
//
//  Created by Ami Intwala on 26/05/21.
//

import Intents

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        guard intent is BillTrackerIntent else {
            fatalError("Unhandled Intent error : \(intent)")
        }
        return BillTrackerHandler()
    }
}

class BillTrackerHandler: NSObject, BillTrackerIntentHandling {
    
    func handle(intent: BillTrackerIntent, completion: @escaping (BillTrackerIntentResponse) -> Void) {
        if let title = intent.title, let price = intent.price {
            let listSize = addBill(title: title, price: Int(truncating: price))
            completion(BillTrackerIntentResponse.success(numberOfInvoices: NSNumber(value: listSize)))
        }
    }
    
    func resolveTitle(for intent: BillTrackerIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        guard let title = intent.title else {
            completion(INStringResolutionResult.needsValue())
            return
        }
        completion(INStringResolutionResult.success(with: title))
    }
    
    func resolvePrice(for intent: BillTrackerIntent, with completion: @escaping (BillTrackerPriceResolutionResult) -> Void) {
        guard let details = intent.price else {
            completion(BillTrackerPriceResolutionResult.needsValue())
            return
        }
        completion(BillTrackerPriceResolutionResult.success(with: Double(truncating: details)))
    }
    
    func addBill(title: String, price: Int) -> Int {
        var data = [[String:Any]]()
        data.append(["title": title, "price": price])
        if let userDefaults = UserDefaults(suiteName: "group.com.simform.temp") {
            if let billData = userDefaults.array(forKey: "BillData") as? [[String: Any]] {
                data.append(contentsOf: billData)
                userDefaults.setValue(data, forKey: "BillData")
            } else {
                userDefaults.setValue(data, forKey: "BillData")
            }
        }
        return data.count
    }
}
