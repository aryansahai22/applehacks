import SwiftUI

struct History: View {
    @State private var journalEntries: [JournalEntry] = []

    var body: some View {
        VStack {
            if !journalEntries.isEmpty {
                List(journalEntries) { entry in
                    VStack(alignment: .leading) {
                        // Display the date and rating of the journal entry
                        HStack {
                            Text("Date: \(entry.date, formatter: shortDateFormatter)")
                                .font(.custom("Avenir", size: 12))
                                .foregroundColor(.gray)
                            Spacer()
                            HStack {
                                ForEach(1..<6) { index in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(index <= entry.rating ? .yellow : .gray)
                                        .font(.custom("Avenir", size: 12))
                                }
                            }
                        }
                        .padding(.bottom, 2)

                        if let image = entry.image {
                            image
                                .resizable()
                                .scaledToFit() // Maintain original proportions
                                .padding(.bottom, 5)
                        }

                        Text(entry.text)
                            .font(.custom("Avenir", size: 14))
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

// Date Formatter
let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
