//
//  Dispatch.swift
//  DispatchSwift
//
//  Created by Andrew Barba on 12/3/15.
//  Copyright © 2015 abarba.me. All rights reserved.
//

import Foundation

public struct Dispatch {
    
    public typealias Block = () -> ()
}

// MARK: - Main / Async

extension Dispatch {
    
    public static func main(delay delay: Double = 0.0, block: Block) {
        async(dispatch_get_main_queue(), delay: delay, block: block)
    }
    
    public static func async(queue: dispatch_queue_t = dispatch_queue_create("com.abarba.dispatch.async", DISPATCH_QUEUE_SERIAL), delay: Double = 0.0, block: Block) {
        let after = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        dispatch_after(after, queue, block)
    }
}

// MARK: - Timers

extension Dispatch {
    
    public static func timerMain(interval interval: Double, block: Block) -> dispatch_source_t {
        return timerAsync(dispatch_get_main_queue(), interval: interval, block: block)
    }
    
    public static func timerAsync(queue: dispatch_queue_t = dispatch_queue_create("com.abarba.dispatch.async", DISPATCH_QUEUE_SERIAL), interval: Double, block: Block) -> dispatch_source_t {
        let timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue)
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, UInt64(interval * Double(NSEC_PER_SEC)), 100)
        dispatch_source_set_event_handler(timer, block)
        dispatch_resume(timer)
        return timer
    }
}

extension dispatch_source_t {
    
    public func invalidate() -> Self {
        dispatch_source_cancel(self)
        return self
    }
}
