import SwiftUI
import AVFoundation

struct Journaling: View {
    @State private var journalEntry: String = ""
    @State private var selectedImage: Image? = nil
    @State private var isImagePickerPresented: Bool = false
    @State private var journalEntries: [JournalEntry] = []
    @State private var rating: Int = 0  // Track the star rating
    
    var body: some View {
        VStack {
            ScrollView {
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
                        HStack {
                            Image(systemName: "camera")
                            Text("Mood Snap!")
                        }
                        .padding()
                        .background(Color.softBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding()
                }
                
                // Star Rating
                HStack {
                    ForEach(1..<6) { index in
                        Image(systemName: "star.fill")
                            .foregroundColor(index <= self.rating ? .yellow : .gray)
                            .onTapGesture {
                                self.rating = index
                            }
                    }
                }
                .padding()
                
                TextEditor(text: $journalEntry)
                    .frame(height: 200)
                    .border(Color.white, width: 1)  // Reduced border thickness
                    .padding()
                    .background(Color.clear)  // Match with the background color
                    .cornerRadius(10)
                
                Button(action: {
                    saveJournalEntry()
                    journalEntry = "" // Clear the text after saving
                    selectedImage = nil // Clear the image after saving
                    rating = 0 // Clear the rating after saving
                }) {
                    Text("Save Entry")
                        .padding()
                        .background(Color.softAqua)  // Changed to lighter blue
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 60) // Add bottom padding to ensure the content does not go underneath the menu bar
            }
        }
        .onTapGesture {
            self.hideKeyboard()  // Dismiss keyboard when tapping outside
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .onAppear {
            loadJournalEntries()
        }
    }
    
    func saveJournalEntry() {
        let newEntry = JournalEntry(text: journalEntry, image: selectedImage, rating: rating)
        journalEntries.append(newEntry)
        saveEntriesToUserDefaults()
    }
    
    func loadJournalEntries() {
        if let data = UserDefaults.standard.data(forKey: "journalEntries"),
           let entries = try? JSONDecoder().decode([JournalEntry].self, from: data) {
            journalEntries = entries
        }
    }
    
    func saveEntriesToUserDefaults() {
        if let data = try? JSONEncoder().encode(journalEntries) {
            UserDefaults.standard.set(data, forKey: "journalEntries")
        }
    }
    
    func checkCameraAccess(completion: @escaping (Bool) -> Void) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            completion(true)
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    completion(granted)
                }
            }
        case .denied, .restricted:
            completion(false)
        @unknown default:
            fatalError("Unknown camera authorization status")
        }
    }
}

let shortDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

// Ensure `JournalEntry` includes a `date` and `rating` property for storing the date and rating of the entry
struct JournalEntry: Identifiable, Codable {
    let id = UUID()
    let text: String
    let imageData: Data?
    let date: Date
    let rating: Int  // Add this property for storing the star rating

    var image: Image? {
        if let data = imageData, let uiImage = UIImage(data: data) {
            return Image(uiImage: uiImage)
        }
        return nil
    }

    init(text: String, image: Image?, rating: Int, date: Date = Date()) {
        self.text = text
        self.date = date
        self.rating = rating  // Initialize with the given rating
        if let image = image, let uiImage = image.asUIImage() {
            self.imageData = uiImage.pngData()
        } else {
            self.imageData = nil
        }
    }
}

extension Image {
    func asUIImage() -> UIImage? {
        let controller = UIHostingController(rootView: self.resizable())
        guard let view = controller.view else { return nil }
        
        let targetSize = CGSize(width: 100, height: 100) // Adjust size if necessary
        view.bounds = CGRect(origin: .zero, size: targetSize)
        view.backgroundColor = .clear
        
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
    }
}

struct Journaling_Previews: PreviewProvider {
    static var previews: some View {
        Journaling()
    }
}
