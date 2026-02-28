//
// Concurrency
// Copyright © 2023 Space Code. All rights reserved.
//

import Foundation

#if swift(>=5.9)
extension DispatchQueue: @preconcurrency IDispatchQueue {
    public func async(
        qos: DispatchQoS,
        flags: DispatchWorkItemFlags,
        execute work: @escaping @Sendable @convention(block) () -> Void
    ) {
        async(group: nil, qos: qos, flags: flags, execute: work)
    }
}
#else
extension DispatchQueue: IDispatchQueue {
    public func async(qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void) {
        async(group: nil, qos: qos, flags: flags, execute: work)
    }
}
#endif
