![image](Resources/MMTToolForFlareIAP.png)

# MMTToolForFlareIAP

[![CI Status](https://img.shields.io/travis/Donghn/MMTToolForFlareIAP.svg?style=flat)](https://travis-ci.org/Donghn/MMTToolForFlareIAP)
[![Version](https://img.shields.io/cocoapods/v/MMTToolForFlareIAP.svg?style=flat)](https://cocoapods.org/pods/MMTToolForFlareIAP)
[![License](https://img.shields.io/cocoapods/l/MMTToolForFlareIAP.svg?style=flat)](https://cocoapods.org/pods/MMTToolForFlareIAP)
[![Platform](https://img.shields.io/cocoapods/p/MMTToolForFlareIAP.svg?style=flat)](https://cocoapods.org/pods/MMTToolForFlareIAP)

## Overview

MMTToolForFlareIAP is a comprehensive wrapper and packaging tool for the Flare IAP framework (synced with Flare 3.3.0). It provides a simplified and unified API for implementing in-app purchases (IAP) in iOS applications, built on top of the robust Flare framework. This library makes it easy to integrate subscription and transaction management into your MMT projects with minimal boilerplate code.

## Features

- 🎯 **Simplified API**: Easy-to-use interface on top of Flare framework
- 📦 **Out-of-the-box Solution**: Ready-to-use IAP implementation
- 🔄 **StoreKit 2 Support**: Full support for iOS 15.0+ with graceful fallback for earlier versions
- 🔐 **Transaction Verification**: Secure handling and verification of app store transactions
- 🔌 **Dependency Injection**: Built-in DI container for better code organization
- 📱 **iOS 13.0+**: Compatible with iOS 13.0 and later versions
- 🧪 **Well-tested**: Comprehensive test coverage for reliability
- 🔄 **Flare 3.3.0**: Synced with latest Flare framework version 3.3.0
- 📝 **Logging System**: Built-in comprehensive logging for debugging and monitoring
- 🎚️ **Log Level**: Public log level control via `Flare.shared.logLevel`
- ⏰ **Expiration Query (0.1.6)**: Subscription ticket expiration time query support
- 🧪 **Sandbox Detection**: Indicates receipt environment when checking subscriptions
- 🏷️ **Product Type (0.1.7)**: Product type retrieval support
- 🔓 **Public API**: Enhanced public API accessibility for better integration

## Requirements

- iOS 13.0 or later
- Swift 5.0+
- Xcode 12.0+

## Installation

MMTToolForFlareIAP is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MMTToolForFlareIAP'
```

Then run `pod install` in your project directory.

## Usage

### Basic Setup

Initialize and configure Flare in your application:

```swift
import MMTToolForFlareIAP

// Configure in your AppDelegate or SceneDelegate
Flare.configure(with: configuration)

// Access the shared instance when needed
let flare = Flare.shared
```

### Check Current Subscriptions

```swift
Flare.checkCurrentSubscriptions { transactionList in
    guard let transactionList = transactionList else {
        print("Failed to fetch subscriptions")
        return
    }

    for transaction in transactionList {
        print("Product ID: \(transaction.productIdentifier)")
        print("Expiration Date: \(transaction.subscribeExpireDate ?? "N/A")")
        print("Purchase Date: \(transaction.purchaseDate ?? "N/A")")
        print("Environment: \(transaction.environment)")
        print("Price: \(transaction.price) \(transaction.currency)")
    }
}
```

#### Transaction Properties

The transaction object provides access to the following properties:

| Property | Type | Description |
|----------|------|-------------|
| `originalID` | String | Original transaction identifier |
| `productIdentifier` | String | Product identifier for the subscription |
| `productType` | String | Type of the product |
| `purchaseDate` | Date? | Date when the subscription was purchased |
| `subscribeExpireDate` | Date? | Date when the subscription expires |
| `hasKnownPurchaseDate` | Bool | Indicates if purchase date is known |
| `transactionIdentifier` | String | Unique transaction identifier |
| `hasKnownTransactionIdentifier` | Bool | Indicates if transaction identifier is known |
| `quantity` | Int | Quantity of items in the transaction |
| `jwsRepresentation` | String | JWS representation of the transaction |
| `environment` | String | Environment (sandbox or production) |
| `price` | String | Price of the subscription |
| `currency` | String | Currency code (e.g., "USD") |
| `appAccountToken` | String? | App account token associated with the transaction |

#### Complete Example

For a complete working example with detailed implementation, see [USAGE_EXAMPLE.md](USAGE_EXAMPLE.md).

### Logging Configuration

The library includes a comprehensive logging system for debugging:

```swift
import MMTToolForFlareIAP

// Logging is automatically configured
// Adjust log level globally when needed
Flare.shared.logLevel = .debug

// Check console output for detailed IAP operation logs
// Logs include: purchases, transactions, receipt validation, and more
```

## Example Project

To run the example project, clone the repo and run `pod install` from the Example directory:

```bash
cd Example
pod install
```

Then open `MMTToolForFlareIAP.xcworkspace` in Xcode and run the example app.

## Architecture

MMTToolForFlareIAP is built with a modular architecture:

- **Core**: Core framework functionality based on Flare 3.3.0
- **Atomic**: Thread-safe operations using atomic values
- **Concurrency**: Async/await support with task factories
- **DI**: Dependency injection container for managing dependencies
- **Extensions**: Convenient extensions for StoreKit integration
- **Models**: Type-safe data models for transactions and subscriptions
- **Providers**: Protocol-based providers for flexible implementations
- **Logger**: Comprehensive logging system with formatters and printers

## What's New

### Version 0.1.9
- Added environment information (String) query support in transaction data
- Removed sandbox environment parameter from subscription history request method
- Environment information is now directly available in transaction objects

### Version 0.1.8
- Added appAccountToken retrieval on StoreTransaction

### Version 0.1.7
- Added product type retrieval support
- Enhanced StoreProduct models with product type information

### Version 0.1.6
- Added subscription ticket expiration time query support

### Version 0.1.5
- Synced with Flare framework 3.3.0
- Added comprehensive logging system for debugging and monitoring
- Enhanced logger with multiple formatters and print strategies
- Improved transaction tracking with detailed logs

### Version 0.1.4
- Enhanced public API accessibility
- Updated internal properties to public for better integration

### Version 0.1.3
- Enhanced transaction models with expiration date properties

### Version 0.1.2-0.1.1
- Initial stable releases
- Core IAP functionality
- StoreKit 2 support

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a new branch for your feature (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Support

If you encounter any issues or have questions, please open an issue on the [GitHub repository](https://github.com/NealWills/MMTToolForFlareIAP).

## Author

Neal Wills, AoiiiiYuki@outlook.com

## License

MMTToolForFlareIAP is available under the MIT license. See the LICENSE file for more info.
