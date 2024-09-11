//
//  DispatchQueue+Extension.swift
//  SwiftEssentials
//
//  Created by Tolga Seremet on 14.03.2023.
//

import Foundation

public extension DispatchQueue {

    /// Executes a background task and optionally completes with a task on the main thread after a delay.
    /// - Parameters:
    ///   - delay: The delay (in seconds) before executing the completion task on the main thread. Default is `0.0`.
    ///   - background: The task to execute in the background.
    ///   - completion: The task to execute on the main thread after the background task. Optional.
    static func background(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}
