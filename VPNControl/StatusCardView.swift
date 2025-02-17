//
//  StatusCardView.swift
//  VPNControl
//
//  Created by Robert Taylor on 2/15/25.
//

import SwiftUI

struct StatusCardView: View {
    let vpnState: VPNState
    let instanceId: String?
    let lastUpdated: Date?
    
    var body: some View {
        VStack(spacing: 16) {
            // Status Icon
            Image(systemName: vpnState.icon)
                .font(.system(size: 50))
                .foregroundColor(vpnState.color)
                //.symbolEffect(.bounce, options: .repeating, value: vpnState.isTransitioning)
            
            // Status Information
            VStack(spacing: 8) {
                // Instance Status
                HStack {
                    Circle()
                        .fill(vpnState.color)
                        .frame(width: 8, height: 8)
                    Text(vpnState.displayText)
                        .font(.headline)
                        .foregroundColor(vpnState.color)
                }
                
                // Instance ID
                if let instanceId = instanceId {
                    VStack(spacing: 4) {
                        Text("Instance ID")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text(instanceId)
                            .font(.subheadline)
                            .monospaced()
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                }
                
                // Last Updated
                if let lastUpdated = lastUpdated {
                    Text("Last updated: \(lastUpdated.formatted(.relative(presentation: .named)))")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 1)
    }
}
