//
//  VPNState.swift
//  VPNControl
//
//  Created by Robert Taylor on 2/15/25.
//

import Foundation
import SwiftUI

enum VPNState: String, Codable {
    case running
    case stopped
    case starting
    case stopping
    
    var displayText: String {
        switch self {
        case .running: return "Running"
        case .stopped: return "Stopped"
        case .starting: return "Starting"
        case .stopping: return "Stopping"
        }
    }
    
    var color: Color {
        switch self {
        case .running: return .green
        case .stopped: return .red
        case .starting, .stopping: return .orange
        }
    }
    
    var icon: String {
        switch self {
        case .running: return "lock.fill"
        case .stopped: return "lock.open.fill"
        case .starting: return "lock.rotation"
        case .stopping: return "lock.rotation"
        }
    }
    
    var isTransitioning: Bool {
        self == .starting || self == .stopping
    }
}

