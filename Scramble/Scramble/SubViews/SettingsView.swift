import SwiftUI
import StoreKit

struct SettingsSheet: View {
    
    @Binding var showSettingsSheet: Bool
    
    @ObservedObject var settingsViewModel = SettingsViewModel()

    var body: some View {
            
        VStack(spacing: 0) {
            ZStack {
                Text("Settings")
                    .font(.title3)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundStyle(.white)
                    .shadow(radius: 4)
                
                HStack {
                    Spacer()
                    Button("Done", action: {
                        withAnimation {
                            showSettingsSheet = false
                        }
                    })
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                }
            }
            .frame(height: 44)
            .padding([.horizontal])
            .padding(.top, 8)
            
            List {
                SupportSection(parentViewModel: settingsViewModel)
            }
            .scrollContentBackground(.hidden)
            
        }
        .background(Color.cyan)
    }
}

struct SettingsSheetButton: View {
    let title: String
    let iconName: String
    var color: Color?
    let action: () -> Void
    var accessibilityIdentifier: String?

    var body: some View {
        Button(action: action) {
            SettingsButtonTextFormat(title: title, iconName: iconName, color: color)
        }
        .accessibilityIdentifier(accessibilityIdentifier ?? "")
    }
}

struct SettingsButtonTextFormat: View {
    let title: String
    let iconName: String
    var color: Color?

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(color ?? .purple)
                .frame(width: 24, height: 24)
            Text(title)
                .foregroundColor(.primary)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.purple)
                .font(.caption2)
        }
    }
}

#Preview {
    SettingsSheet(showSettingsSheet: .constant(true))
}
