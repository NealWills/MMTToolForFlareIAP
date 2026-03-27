//
//  ViewController.swift
//  MMTToolForFlareIAP
//
//  Created by Donghn on 09/09/2025.
//  Copyright (c) 2025 Donghn. All rights reserved.
//

import MMTToolForFlareIAP
import UIKit

class ViewController: UIViewController {
    var dataList: [StoreTransaction] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Flare.checkRecordSubscriptions { [weak self] transactionList in
            for i in 0 ..< (transactionList?.count ?? 0) {
                if let transaction = transactionList?[i] {
                    var params: [String: Any] = [:]
                    // 原始票据ID
                    params["originalID"] = transaction.originalID
                    // 原始商品id
                    params["productIdentifier"] = transaction.productIdentifier
                    // 商品类型
                    params["productType"] = transaction.productType
                    // 购买日期
                    params["purchaseDate"] = transaction.purchaseDate
                    // 过期日期
                    params["subscribeExpireDate"] = transaction.subscribeExpireDate
                    // 是否已知购买日期
                    params["hasKnownPurchaseDate"] = transaction.hasKnownPurchaseDate
                    // 交易ID
                    params["transactionIdentifier"] = transaction.transactionIdentifier
                    // 是否已知交易ID
                    params["hasKnownTransactionIdentifier"] = transaction.hasKnownTransactionIdentifier
                    // 购买数量
                    params["quantity"] = transaction.quantity
                    // jws交易信息
                    params["jwsRepresentation"] = transaction.jwsRepresentation
                    // 环境
                    params["environment"] = transaction.environment
                    // 环境字符串
                    params["environmentStr"] = transaction.environmentStr
                    // 价格
                    params["price"] = transaction.price
                    // 货币
                    params["currency"] = transaction.currency
                    // 应用账户令牌
                    params["appAccountToken"] = transaction.appAccountToken
                }
            }

            let list = transactionList ?? []
            self?.dataList = list
            self?.checkRenewSubscribe(productList: list)
        }
    }

    func checkRenewSubscribe(productList: [StoreTransaction]) {
        var productIdList: [String] = []
        var renewTransactionList: [StoreTransaction] = []
        let sortList = productList.sorted { model1, model2 in
            if let date1 = model1.subscribeExpireDate, let date2 = model2.subscribeExpireDate {
                return date1 > date2
            }
            return false
        }
        for item in sortList {
            if !productIdList.contains(item.productIdentifier) {
                productIdList.append(item.productIdentifier)
                renewTransactionList.append(item)
            }
        }
        Flare.checkRenewSubscriptions(
            transactionList: renewTransactionList,
            resultBlock: { [weak self] renewInfoList in
                for i in 0 ..< (renewInfoList?.count ?? 0) {
                    if let item = renewInfoList?[i] {
                        let renewInfo = item.0
                        let renewStatus = item.1

                        // 续订状态
                        var params: [String: Any] = [:]
                        switch renewStatus {
                        case .subscribed:
                            params["renewStatus"] = "subscribed"
                        case .expired:
                            params["renewStatus"] = "expired"
                        case .inBillingRetryPeriod:
                            params["renewStatus"] = "inBillingRetryPeriod"
                        case .revoked:
                            params["renewStatus"] = "revoked"
                        case .inGracePeriod:
                            params["renewStatus"] = "inGracePeriod"
                        case .unknown:
                            params["renewStatus"] = "unknown"
                        default:
                            break
                        }

                        // 续订信息
//                        params["jsonRepresentation"] = renewInfo.jsonRepresentation
                        // 原始交易ID
                        params["originalTransactionID"] = renewInfo.originalTransactionID
                        // 商品ID
                        params["willAutoRenew"] = renewInfo.willAutoRenew ? 1 : 0
                        // 续订状态
                        params["autoRenewPreference"] = renewInfo.autoRenewPreference
                        // 是否在续订宽限期内
                        params["isInBillingRetry"] = renewInfo.isInBillingRetry ? 1 : 0
                        // 是否在续订宽限期内
//                        params["gracePeriodExpirationDate"] = renewInfo.gracePeriodExpirationDate
                        // offerId
                        params["offerID"] = renewInfo.offerID
                        // 当前商品ID
                        params["currentProductID"] = renewInfo.currentProductID
                        // 过期原因
                        switch renewInfo.expirationReason {
                        case .autoRenewDisabled:
                            params["expirationReason"] = "autoRenewDisabled"
                        case .billingError:
                            params["expirationReason"] = "billingError"
                        case .didNotConsentToPriceIncrease:
                            params["expirationReason"] = "didNotConsentToPriceIncrease"
                        case .productUnavailable:
                            params["expirationReason"] = "productUnavailable"
                        case .unknown:
                            params["expirationReason"] = "unknown"
                        default:
                            break
                        }

                        // 续订价格变更状态
                        switch renewInfo.priceIncreaseStatus {
                        case .noIncreasePending:
                            params["priceIncreaseStatus"] = "noIncreasePending"
                        case .pending:
                            params["priceIncreaseStatus"] = "pending"
                        case .agreed:
                            params["priceIncreaseStatus"] = "agreed"
                        }
                        // 续订价格
                        params["renewalPrice"] = renewInfo.renewalPrice
                        // 续订货币
                        params["currency"] = renewInfo.currency
                    }
                }
            }
        )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
