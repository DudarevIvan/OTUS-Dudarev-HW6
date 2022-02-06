//
//  TextInputScreen.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

struct TextInputScreen: View {
    // View Model
    @EnvironmentObject var suffixViewModel: SuffixViewModel
    // Input text
    @State private var text: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextEditor(text: $text)
                Spacer()
            }
            .onTapGesture { hideKeyboardAndSave() }
            .padding()
            .navigationTitle("Enter text")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    // Hide keyboard on tap gesture and save text
    private func hideKeyboardAndSave() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        if !text.isEmpty {
            suffixViewModel.setSuffixData(text)
        }
    }
}

struct TextInputScreen_Previews: PreviewProvider {
    static var previews: some View {
        TextInputScreen()
    }
}
