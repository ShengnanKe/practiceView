//
//  SwiftUIView.swift
//  practiceView
//
//  Created by KKNANXX on 7/2/24.
//
import SwiftUI


struct SwiftUIView: View {
    @State private var locations: [LocationData] = []
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            List {
                ForEach(locations) { location in
                    VStack(alignment: .center) {
                        Text("City: \(location.city)")
                        Text("Country: \(location.country)")
                    }
                }
            }
            .navigationTitle("Show Locations")
            .onAppear {
                loadLocation()
            }
        }
    }

    func loadLocation() {
        isLoading = true
        Task {
            do {
                let data: [LocationData] = try await HttpClient().fetch(urlString: "https://raw-tutorial.s3.eu-west-1.amazonaws.com/patients.json")
                locations = data
            } catch {
                print("Cannot load data: \(error.localizedDescription)")
                errorMessage = "Cannot load data: \(error.localizedDescription)"
            }
            isLoading = false
        }
    }
}

#Preview {
    SwiftUIView()
}
