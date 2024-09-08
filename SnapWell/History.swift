import SwiftUI

struct History: View {
    @State private var journalEntries: [JournalEntry] = []
    
    var body: some View {
        VStack {
            if !journalEntries.isEmpty {
                List(journalEntries) { entry in
                    VStack(alignment: .leading) {
                        if let image = entry.image {
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                        Text(entry.text)
                            .font(.headline)
                            .padding(.top, 5)
                    }
                    .padding(.vertical)
                }
            } else {
                Text("No history available")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding()
            }
            
            Button(action: {
                clearHistory()
            }) {
                Text("Clear History")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: loadJournalEntries)
    }
    
    func loadJournalEntries() {
        if let data = UserDefaults.standard.data(forKey: "journalEntries"),
           let entries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            journalEntries = entries
        }
    }
    
    func clearHistory() {
        journalEntries.removeAll()
        saveEntriesToUserDefaults()  // Save the empty state to UserDefaults
    }
    
    func saveEntriesToUserDefaults() {
        if let data = try? JSONEncoder().encode(journalEntries) {
            UserDefaults.standard.set(data, forKey: "journalEntries")
        }
    }
}

struct History_Previews: PreviewProvider {
    static var previews: some View {
        History()
    }
}
