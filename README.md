# VPNControl iOS App

A SwiftUI-based iOS application for controlling a personal AWS-hosted OpenVPN server. This app was created during a sabbatical in Taipei as part of a larger project to build a personal VPN service. The entire codebase was generated with the assistance of AI tools (ChatGPT and Claude).

## Project Overview

VPNControl is designed to work with a custom AWS infrastructure that includes:
- An EC2 instance running OpenVPN
- API Gateway and Lambda for server control
- Infrastructure defined with Terraform

The app provides a simple interface to:
- Start and stop your VPN instance
- Monitor VPN status in real-time
- Securely store API credentials

## 🚀 Getting Started

### Prerequisites

- Xcode 15.0 or later
- iOS 16.0 or later
- An AWS infrastructure set up with:
  - API Gateway endpoint
  - API Key for authentication
  - Lambda function for EC2 control
  - EC2 instance configured with OpenVPN

### Setup

1. Clone the repository:
```bash
git clone git@github.com:rjamestaylor/VPNControl.git
```

2. Create a new Xcode project:
   - Create a new iOS app project in Xcode
   - Choose "SwiftUI App" as the interface
   - Set minimum deployment target to iOS 16.0
   - Add the Swift files from this repository to your project

3. Configure the API endpoint:
   - Open `VPNApiClient.swift`
   - Replace the `baseURL` with your API Gateway URL:
```swift
private let baseURL = "https://your-api-gateway-url.execute-api.us-east-1.amazonaws.com/Prod"
```

4. Build and run the project in Xcode

### API Key Configuration

The app requires an API key for authentication. Once you have your API key from AWS:
1. Launch the app
2. Go to Settings
3. Enter your API key
4. The key will be securely stored in the iOS Keychain

## 📱 App Architecture

### MVVM Architecture
The app follows the MVVM (Model-View-ViewModel) pattern:
- **Models**: `VPNState`, `StatusInfo`
- **Views**: `ContentView`, `StatusCardView`, `SettingsView`
- **ViewModels**: `VPNViewModel`, `AppSettings`

### Key Components

#### Views
- `ContentView.swift`: Main interface with VPN controls
- `StatusCardView.swift`: Visual representation of VPN status
- `SettingsView.swift`: API key management

#### View Models
- `VPNViewModel.swift`: Manages VPN state and API interactions
- `AppSettings.swift`: Handles app configuration and API key storage

#### Networking
- `VPNApiClient.swift`: API client for VPN control endpoints
- Implements async/await for network calls
- Handles API authentication and error cases

#### Security
- `KeychainManager.swift`: Secure storage for API credentials
- Implements best practices for iOS keychain usage

## 🔒 Security Features

- API keys stored securely in iOS Keychain
- HTTPS for all API communications
- AWS API Gateway authentication
- No VPN credentials stored in the app

## 🛠 Technical Details

### Networking
The app uses URLSession with async/await for API calls:
```swift
func getStatus() async throws -> [String: Any] {
    guard let url = URL(string: "\(baseURL)/vpn/status") else {
        throw VPNError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
    
    let (data, response) = try await session.data(for: request)
    // ... response handling
}
```

### State Management
VPN state is managed through a state enum with associated UI properties:
```swift
enum VPNState: String, Codable {
    case running
    case stopped
    case starting
    case stopping
    
    var isTransitioning: Bool {
        self == .starting || self == .stopping
    }
}
```

### Error Handling
Comprehensive error handling for network and keychain operations:
```swift
enum VPNError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case decodingError
}
```

## 🤖 AI Development

This project demonstrates the potential of AI-assisted development. The entire codebase was generated through conversations with AI tools, with human oversight for:
- Architecture decisions
- Security considerations
- UI/UX choices
- Integration points

## 📝 Requirements for AWS Infrastructure

The app expects these API endpoints:
- POST `/vpn` - Start/Stop VPN instance
- GET `/vpn/status` - Get VPN status

API requests must include:
- `x-api-key` header for authentication
- JSON body for POST requests
- Query parameters for GET requests

## 🤝 Contributing

This project is open for contributions. Please:
1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ✨ Acknowledgments

- OpenVPN for the VPN server software
- AWS for the cloud infrastructure
- ChatGPT and Claude for code generation assistance
- https://www.appicon.co/#image-sets for quickly creating the image sets from the main PNG

## 🔍 Related Projects

- [VPN Infrastructure Terraform Code](link-to-terraform-repo)
- [VPN Control Lambda Function](link-to-lambda-repo)

## 📞 Contact

For questions or suggestions, please open an issue in the repository. Or, reference this repo and ask ChatGPT or Claude to resolve your issue. That's the spirit of this project.