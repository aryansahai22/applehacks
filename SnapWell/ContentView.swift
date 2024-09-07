import SwiftUI

struct ContentView: View {
    @State private var journalEntry: String = ""
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Today's Date: \(Date(), formatter: DateFormatter.shortDate)")
                .font(.headline)
                .padding()
            
            if let image = selectedImage {
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
                    .padding()
            } else {
                Button(action: {
                    isImagePickerPresented = true
                }) {
                    Text("Capture Photo")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            
            TextEditor(text: $journalEntry)
                .frame(height: 200)
                .border(Color.gray, width: 1)
                .padding()
            
            Button(action: {
                // Save the journal entry
                saveJournalEntry()
            }) {
                Text("Save Entry")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
    }
    
    func saveJournalEntry() {
        // Code to save the journal entry
        print("Journal entry saved: \(journalEntry)")
    }
}

extension DateFormatter {
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
