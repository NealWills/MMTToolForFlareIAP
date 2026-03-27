//
//  Flare+RenewSubscrip.swift
//  MMTToolForFlareIAP
//
//  Created by Maxeye_Neal on 27/03/2026.
//

import Foundation
import StoreKit

// RenewalInfo
// RenewalState

/// Extension for Flare to handle subscription and transaction records.
public extension Flare {
    /// Checks current subscriptions for iOS 15.0+, falling back to older implementation for earlier versions.
    /// - Parameter resultBlock: Callback block that returns an array of StoreTransaction objects or nil if an error occurs.
    class func checkRenewSubscriptions(transactionList: [StoreTransaction], resultBlock: ((_ renewInfoList: [(RenewalInfo, RenewalState?)]?) -> Void)?) {
        if #available(iOS 15.0, *) {
            checkRenewSubscriptions15AndUp(transactionList: transactionList, resultBlock: resultBlock)
        } else {
            checkRenewSubscriptions15Down(transactionList: transactionList, resultBlock: resultBlock)
        }
    }

    /// Fetches current subscriptions using StoreKit 2 API for iOS 15.0 and above.
    /// Uses async/await to fetch all transactions from the device and verifies them.
    /// - Parameter resultBlock: Callback block that receives the verified transactions list and a boolean indicating if the environment is sandbox.
    @available(iOS 15.0, *)
    fileprivate class func checkRenewSubscriptions15AndUp(transactionList: [StoreTransaction], resultBlock: ((_ renewInfoList: [(RenewalInfo, RenewalState?)]?) -> Void)?) {
        Task {
            
            var list: [(RenewalInfo, RenewalState?)] = []
            for i in 0 ..< transactionList.count {
                let transaction = transactionList[i]
                let sk2Transaction = transaction.storeTransaction as? SK2StoreTransaction
                let storeTransaction = sk2Transaction?.transaction
                let subscriptionStatus = await storeTransaction?.subscriptionStatus
                let renewalState = subscriptionStatus?.renewalState
                let renewalInfo = subscriptionStatus?.renewalInfo
                let subscriptionRenewalInfo = subscriptionStatus?.subscriptionRenewalInfo
                switch renewalInfo {
                case .unverified(let signedType, let verificationError):
                    let info = RenewalInfo.init(renewalInfo: signedType)
                    let item = (info, renewalState)
                    list.append(item)
                case .verified(let signedType):
                    let info = RenewalInfo.init(renewalInfo: signedType)
                    let item = (info, renewalState)
                    list.append(item)
                    break
                default:
                    break
                }
                resultBlock?(list)
            }
        }
    }

    /// Fallback implementation for checking subscriptions on iOS versions below 15.0.
    /// Currently returns nil as StoreKit 2 is not available on older iOS versions.
    /// - Parameter resultBlock: Callback block that receives the transactions list or nil.
    fileprivate class func checkRenewSubscriptions15Down(transactionList _: [StoreTransaction], resultBlock: ((_ renewInfoList: [(RenewalInfo, RenewalState?)]?) -> Void)?) {
        // StoreKit 2 is unavailable on iOS < 15.0, return nil
        resultBlock?(nil)
    }
}
