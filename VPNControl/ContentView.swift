//
//  ContentView.swift
//  VPNControl
//
//  Created by Robert Taylor on 2/14/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = VPNViewModel()
    @EnvironmentObject var settings: AppSettings
    @State private var showingSettings = false
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    StatusCardView(
                        vpnState: viewModel.vpnState,
                        instanceId: viewModel.instanceId,
                        lastUpdated: viewModel.lastUpdated
                    )
                    
                    // Control Button
                    Button(action: {
                        Task {
                            await viewModel.toggleVPN()
                        }
                    }) {
                        Text(viewModel.vpnState == .stopped ? "Start VPN" : "Stop VPN")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(viewModel.vpnState == .stopped ? Color.green : Color.red)
                            .cornerRadius(10)
                    }
                    .disabled(viewModel.isLoading || viewModel.vpnState.isTransitioning)
                }
                .padding(.vertical)
            }
        }
        .navigationTitle("VPN Control")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    Task {
                        await viewModel.forceRefresh()
                    }
                }) {
                    Image(systemName: "arrow.clockwise")
                }
                .disabled(viewModel.isLoading)
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { showingSettings = true }) {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            NavigationStack {
                SettingsView()
            }
        }
        .onAppear {
            viewModel.updateApiKey(settings.apiKey)
            Task {
                await viewModel.checkStatus()
            }
        }
        .onChange(of: settings.apiKey) { newValue in
            viewModel.updateApiKey(newValue)
        }
    }
}
