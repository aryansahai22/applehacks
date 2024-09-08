import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Home()
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            Journaling()
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Journal")
                }
            History()
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
        }
        .accentColor(.blue) // Ensures that the selected tab item color is blue
        .ignoresSafeArea(edges: .bottom) // Ensures the TabView is not obscured
        .navigationViewStyle(StackNavigationViewStyle()) // This prevents unintended stack behavior
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
