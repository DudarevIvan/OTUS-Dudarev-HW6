//
//  HistoryScreen.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

struct HistoryScreen: View {
    
    //ViewModel
    @EnvironmentObject var suffixViewModel: SuffixViewModel
    
    var body: some View {
        NavigationView {
            List() {
                ForEach(suffixViewModel.history, id: \.self) { item in
                    HStack {
                        Text(item)
                        Spacer()
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .navigationTitle("History")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HistoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        HistoryScreen()
    }
}
