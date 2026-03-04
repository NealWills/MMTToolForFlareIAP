# MMTToolForFlareIAP 使用示例

## 检查当前订阅

本示例展示如何使用 `Flare` 库来检查用户的当前订阅信息。

### 代码示例

```swift
import MMTToolForFlareIAP
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        Flare.checkCurrentSubscriptions { transactionList in
            var list: [[String: Any]] = []
            for i in 0 ..< (transactionList?.count ?? 0) {
                if let transaction = transactionList?[i] {
                    let params: [String: Any] = [
                        "originalID": transaction.originalID,
                        "productIdentifier": transaction.productIdentifier,
                        "productType": transaction.productType,
                        "purchaseDate": transaction.purchaseDate,
                        "subscribeExpireDate": transaction.subscribeExpireDate,
                        "hasKnownPurchaseDate": transaction.hasKnownPurchaseDate,
                        "transactionIdentifier": transaction.transactionIdentifier,
                        "hasKnownTransactionIdentifier": transaction.hasKnownTransactionIdentifier,
                        "quantity": transaction.quantity,
                        "jwsRepresentation": transaction.jwsRepresentation,
                        "environment": transaction.environment,
                        "price": transaction.price,
                        "currency": transaction.currency,
                        "appAccountToken": transaction.appAccountToken,
                    ]
                    list.append(params)
                }
            }

            print(list)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
```

### 说明

1. **导入库**: 在 `ViewController` 中导入 `MMTToolForFlareIAP` 模块
2. **调用方法**: 在 `viewDidLoad()` 中调用 `Flare.checkCurrentSubscriptions(_:)` 方法
3. **处理回调**: 通过闭包接收订阅信息列表 `transactionList`
4. **提取数据**: 遍历交易列表，从每个交易对象中提取以下信息：
   - `originalID` - 原始交易 ID
   - `productIdentifier` - 产品标识符
   - `productType` - 产品类型
   - `purchaseDate` - 购买日期
   - `subscribeExpireDate` - 订阅过期日期
   - `hasKnownPurchaseDate` - 是否有已知的购买日期
   - `transactionIdentifier` - 交易标识符
   - `hasKnownTransactionIdentifier` - 是否有已知的交易标识符
   - `quantity` - 数量
   - `jwsRepresentation` - JWS 表示
   - `environment` - 环境（沙箱/生产）
   - `price` - 价格
   - `currency` - 货币
   - `appAccountToken` - 应用账户令牌

### 使用场景

此示例适用于以下场景：
- 应用启动时检查用户的有效订阅
- 显示用户的订阅状态和过期日期
- 记录和分析订阅数据
- 为用户提供个性化的功能访问权限

