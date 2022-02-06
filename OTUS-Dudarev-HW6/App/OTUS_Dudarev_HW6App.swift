//
//  OTUS_Dudarev_HW6App.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

@main
struct OTUS_Dudarev_HW6App: App {
    
    let suffixViewModel: SuffixViewModel = .init()
    
    var body: some Scene {
        WindowGroup {
            TabScreen()
                .environmentObject(suffixViewModel)
        }
    }
}
