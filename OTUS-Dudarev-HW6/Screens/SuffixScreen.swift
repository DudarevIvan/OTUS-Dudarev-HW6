//
//  SuffixScreen.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

struct SuffixScreen: View {
    
    // ViewModel
    @EnvironmentObject var suffixViewModel: SuffixViewModel
    // Sort type
    @State private var selection: SortType = .allABC
    // Search text
    @State private var searchText: String = .init()
    // For save search history
    @Environment(\.dismissSearch) private var dismissSearch
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $selection, label: Text("text")) {
                    ForEach(SortType.allCases, id: \.self) { value in
                        Text(value.localizedName)
                            .tag(value)
                    }
                }
                .pickerStyle(.segmented)
                //Suffix List
                if let suffix = suffixViewModel.sortSuffix(selection) {
                    List() {
                        ForEach(self.filteredSuffixes(suffix)) { item in
                            HStack {
                                Text(item.value)
                                Spacer()
                                Text("\(item.numberOfMatches)")
                            }
                        }
                    }
                    .listStyle(.plain)
                    .navigationTitle("Suffixes")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .padding()
        }
        .searchable(text: $suffixViewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
        // Save search history
        .onSubmit(of: .search) {
            suffixViewModel.history.append(suffixViewModel.searchText)
        }
    }
    
    // Filtered suffixes
    func filteredSuffixes(_ suffix: Array<Suffix>) -> Array<Suffix> {
        if suffixViewModel.searchText == "" { return suffix }
        return suffix.filter { $0.value.lowercased().contains(suffixViewModel.searchText.lowercased()) }
    }
}

struct SuffixScreen_Previews: PreviewProvider {
    static var previews: some View {
        SuffixScreen()
    }
}
