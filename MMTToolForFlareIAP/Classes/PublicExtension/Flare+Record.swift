//
//  Flare+Record.swift
//  MMTToolForFlareIAP
//
//  Created by Maxeye_Neal on 28/02/2026.
//

import Foundation
import StoreKit

/// Extension for Flare to handle subscription and transaction records.
public extension Flare {
    /// Checks current subscriptions for iOS 15.0+, falling back to older implementation for earlier versions.
    /// - Parameter resultBlock: Callback block that returns an array of StoreTransaction objects or nil if an error occurs.
    class func checkCurrentSubscriptions(_ resultBlock: ((_ storeTransactionList: [StoreTransaction]?, _ isSandbox: Bool) -> Void)?) {
        if #available(iOS 15.0, *) {
            checkCurrentSubscriptions15AndUp(resultBlock)
        } else {
            checkCurrentSubscriptions15Down(resultBlock)
        }
    }

    /// Fetches current subscriptions using StoreKit 2 API for iOS 15.0 and above.
    /// Uses async/await to fetch all transactions from the device and verifies them.
    /// - Parameter resultBlock: Callback block that receives the verified transactions list and a boolean indicating if the environment is sandbox.
    @available(iOS 15.0, *)
    fileprivate class func checkCurrentSubscriptions15AndUp(_ resultBlock: ((_ storeTransactionList: [StoreTransaction]?, _ isSandbox: Bool) -> Void)?) {
        Task {

            var isSandbox = false

            // Check if running in sandbox environment
            if let receiptURL = Bundle.main.appStoreReceiptURL {
                isSandbox = receiptURL.path.contains("sandboxReceipt") ||
                    receiptURL.path.contains("StoreKitTest")
                // print("Sandbox environment: \(isSandbox)")
            }

            var transactionList: [StoreTransaction] = []
            for await result in Transaction.all {
                switch result {
                case let .verified(transaction):
                    // Convert verified SK2 transaction to our StoreTransaction model
                    let sk2Transaction = SK2StoreTransaction(transaction: transaction, jwsRepresentation: transaction.jsonRepresentation.base64EncodedString())
                    let storeTransaction = StoreTransaction(storeTransaction: sk2Transaction)
                    transactionList.append(storeTransaction)
                    // Important: must finish the transaction after processing
                    await transaction.finish()

                case .unverified:
                    // Skip unverified transactions
                    continue
                }
            }

            resultBlock?(transactionList, isSandbox)
        }
    }

    /// Fallback implementation for checking subscriptions on iOS versions below 15.0.
    /// Currently returns nil as StoreKit 2 is not available on older iOS versions.
    /// - Parameter resultBlock: Callback block that receives the transactions list or nil.
    fileprivate class func checkCurrentSubscriptions15Down(_ resultBlock: ((_ storeTransactionList: [StoreTransaction]?, _ isSandbox: Bool) -> Void)?) {
        // StoreKit 2 is unavailable on iOS < 15.0, return nil
        resultBlock?(nil, false)
    }
}
