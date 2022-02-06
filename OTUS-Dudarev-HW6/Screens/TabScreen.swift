//
//  TabScreen.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

struct TabScreen: View {
   
   //Active tab
   @State private var activeTab = TabIdentifier.textTab
   
   var body: some View {
      TabView(selection: $activeTab) {
         TextInputScreen()
            .tabItem {
               VStack {
                  Image(systemName: "text.aligncenter")
                  Text("Text")
               }
            }
            .tag(TabIdentifier.textTab)
         SuffixScreen()
            .tabItem {
               VStack {
                  Image(systemName: "textformat.alt")
                  Text("Suffixes")
               }
            }
            .tag(TabIdentifier.sufixTab)
          HistoryScreen()
              .tabItem {
                 VStack {
                    Image(systemName: "clock")
                    Text("History")
                 }
              }
              .tag(TabIdentifier.historyTab)
      }
      //Link
      .onOpenURL { url in
         guard let tabIdentifier = url.tabIdentifier else {
            return
         }
         activeTab = tabIdentifier
      }
   }
}

struct TabView_Previews: PreviewProvider {
    static var previews: some View {
        TabScreen()
    }
}
