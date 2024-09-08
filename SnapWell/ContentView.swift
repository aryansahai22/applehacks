import SwiftUI

struct ContentView: View {
    @State private var journalEntry: String = ""
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        VStack {
            Text("Today's Date: \(Date(), formatter: shortDateFormatter)")
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
                    checkCameraAccess { granted in
                        if granted {
                            isImagePickerPresented = true
                        } else {
                            print("Camera access denied. Please enable it in settings.")
                        }
                    }
                }) {
                    Text("Take a Photo!")
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
        .fullScreenCover(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
                .ignoresSafeArea(edges: .all)
        }
    }
    
    func saveJournalEntry() {
        print("Journal entry saved: \(journalEntry)")
    }
}

let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
