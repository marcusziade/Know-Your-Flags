import MapKit
import SwiftUI

struct CountryDetail: View {
    
    @StateObject var viewModel: CountryDetailVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                AsyncImage(url: viewModel.country.flag) {
                    $0.image?
                        .resizable()
                        .frame(height: 250)
                }
                
                VStack(alignment: .leading, spacing: 20) {
                    Text(viewModel.country.name.official)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    DetailSection(header: "Capital") { Text(viewModel.country.capitalCity) }
                    DetailSection(header: "Region") { Text(viewModel.country.region) }
                    DetailSection(header: "Population") { Text("\(viewModel.country.population)") }
                    
                    DetailSection(header: "Currencies") {
                        ForEach(viewModel.country.countryCurrencies, id: \.self) { Text($0) }
                    }
                    
                    DetailSection(header: "Languages") {
                        ForEach(viewModel.country.countryLanguages, id: \.self) { Text($0) }
                    }
                    
                    if let url = viewModel.wikipediaURL {
                        Link(destination: url) {
                            Text("Study on Wikipedia")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                        .padding(.vertical)
                    }
                    
                    MapsSection(country: viewModel.country, viewModel: viewModel)
                }
                .padding(.horizontal)
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailSection<Content: View>: View {
    let header: String
    let content: Content
    
    init(header: String, @ViewBuilder content: () -> Content) {
        self.header = header
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header).font(.headline).foregroundColor(.accentColor)
            content
        }
    }
}

struct MapsSection: View {
    let country: Country
    @ObservedObject var viewModel: CountryDetailVM
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Maps").font(.headline).foregroundColor(.accentColor)
            NavigationLink(destination: Map(coordinateRegion: $viewModel.region).edgesIgnoringSafeArea(.all)) {
                Label("Apple Maps", systemImage: "map")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Link(destination: country.googleMap) {
                Label("Google Maps", systemImage: "map")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            Link(destination: country.openStreetMap) {
                Label("Open Street Map", systemImage: "map")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
}