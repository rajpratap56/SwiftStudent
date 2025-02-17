import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            AdvisoryView()
                .tabItem {
                    Image(systemName: "headphones.circle.fill")
                    Text("Advisory")
                }
            
            CropView()
                .tabItem {
                    Image(systemName: "leaf.arrow.circlepath")
                    Text("Crop")
                }
        }
        .accentColor(.green)
    }
}

