//
//  Reader.swift
//  LibrarySystemV5
//
//  Created by Christian Marcelin on 04/04/2025.
//

import SwiftUI
import PDFKit

struct PDFViewRepresentable: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ uiView: PDFView, context: Context) {
        if let document = PDFDocument(url: url) {
            uiView.document = document
        }
    }
}

struct Reader: View {
    @State private var pdfURL: URL?
    
    let url: URL // URL passed as an argument

    var body: some View {
        VStack {
            if let pdfURL = pdfURL {
                PDFViewRepresentable(url: pdfURL)
                    .edgesIgnoringSafeArea(.all)  // Display the PDF in full-screen
            } else {
                Text("Loading PDF...")
                    .onAppear {
                        // Directly set the URL passed to Reader
                        self.pdfURL = url
                    }
            }
        }
        .navigationTitle("PDF Reader")
    }


    // Function to download the PDF from a URL
    func downloadPDF(from url: String, completion: @escaping (URL?) -> Void) {
        guard let pdfURL = URL(string: url) else {
            completion(nil)
            return
        }

        let task = URLSession.shared.downloadTask(with: pdfURL) { localURL, _, _ in
            if let localURL = localURL {
                completion(localURL)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}

#Preview {
    Reader(url: URL(string: "https://www.anthropomada.com/bibliotheque/CAMUS-Letranger.pdf")!)
}
