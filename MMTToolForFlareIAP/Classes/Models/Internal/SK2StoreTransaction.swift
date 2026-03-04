//
// Flare
// Copyright © 2024 Space Code. All rights reserved.
//

import Foundation
import StoreKit

// MARK: - SK2StoreTransaction

/// A struct representing the second version of the transaction.
@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
struct SK2StoreTransaction {
    // MARK: Properties

    /// The StoreKit transaction.
    let transaction: StoreKit.Transaction
    /// The raw JWS representation of the transaction.
    private let _jwsRepresentation: String?

    // MARK: Initialization

    /// Creates a new `SK1StoreTransaction` instance.
    ///
    /// - Parameters:
    ///   - transaction: The StoreKit transaction.
    ///   - jwsRepresentation: The raw JWS representation of the transaction.
    init(transaction: StoreKit.Transaction, jwsRepresentation: String) {
        self.transaction = transaction
        _jwsRepresentation = jwsRepresentation
    }
}

// MARK: IStoreTransaction

@available(iOS 15.0, tvOS 15.0, watchOS 8.0, macOS 12.0, *)
extension SK2StoreTransaction: IStoreTransaction {


    var originalID: UInt64? {
        transaction.originalID
    }

    var originalPurchaseDate: Date? {
        transaction.originalPurchaseDate
    }

    var productIdentifier: String {
        transaction.productID
    }

    var productType: String {
        switch transaction.productType {
            case .autoRenewable:
                return "AutoRenewable"
            case .nonRenewable:
                return "NonRenewable"
            case .consumable:
                return "Consumable"
            case .nonConsumable:
                return "NonConsumable"
            default:
                return "Other"
        }
    }


    var purchaseDate: Date {
        transaction.purchaseDate
    }

    public var subscribeExpireDate: Date? {
        transaction.expirationDate
    }

    var hasKnownPurchaseDate: Bool {
        true
    }

    var transactionIdentifier: String {
        String(transaction.id)
    }

    var hasKnownTransactionIdentifier: Bool {
        true
    }

    var quantity: Int {
        transaction.purchasedQuantity
    }

    var jwsRepresentation: String? {
        _jwsRepresentation
    }

    var environment: StoreEnvironment? {
        StoreEnvironment(transaction: transaction)
    }

    var price: Decimal? {
        #if swift(>=6.0)
            transaction.price
        #else
        transaction.price
        #endif
    }

    var currency: String? {
        #if swift(>=6.0)
            if #available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *) {
                transaction.currency?.identifier
            } else {
                transaction.currencyCode
            }
        #else
        if #available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *) {
            transaction.currency?.identifier
        } else {
            transaction.currencyCode
        }
        #endif
    }

    var appAccountToken: String? {
        transaction.appAccountToken?.uuidString
    }

    var ownershipType: String? {
        transaction.ownershipType.rawValue
    }

    var signedDate: Date? {
        transaction.signedDate
    }

    func purchaseResultDidUpdate(statusBlock: ((String?)->())?) {

        if #available(iOS 15.0, *) {

            Task {
                let status = await transaction.subscriptionStatus?.state
                switch status {
                    case .subscribed:
                        statusBlock?("subscribed")
                    case .expired:
                        statusBlock?("expired")
                    case .inBillingRetryPeriod:
                        statusBlock?("inBillingRetryPeriod")
                    case .inGracePeriod:
                        statusBlock?("inGracePeriod")
                    case .revoked:
                        statusBlock?("revoked")
                    default:
                        statusBlock?(nil)
                }
            }
        } else {
            statusBlock?(nil)
        }

    }

}
