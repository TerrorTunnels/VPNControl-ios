//
//  StatusInfo.swift
//  VPNControl
//
//  Created by Robert Taylor on 2/15/25.
//

import Foundation

struct StatusInfo: Codable {
    let state: VPNState
    let instanceId: String?
    let lastUpdated: Date
    let message: String
}
