//
//  SuffixViewModel.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI
import Combine
import WidgetKit

class SuffixViewModel: ObservableObject {
 
   //Model
   private var suffixModel: SuffixModel = .init()
   
   //Storage
   @AppStorage("suffixData", store: UserDefaults(suiteName: "group.dudarev-group"))
   private var suffixData: Data = .init()
    
    // History finded
    var history: Array<String> = .init()
   
   //Search text
    @Published var searchText: String = .init()
      
   //Sort suffix
   func sortSuffix(_ sortType: SortType) -> Array<Suffix>? {
      guard let suffixes = getSuffixData else { return nil }
      switch sortType {
         case .allABC:
            return suffixes.sorted { $0.value < $1.value }
         case .allASC:
            return suffixes.sorted { $0.numberOfMatches < $1.numberOfMatches }
         case .allDESC:
            return suffixes.sorted { $0.numberOfMatches > $1.numberOfMatches }
         case .top:
            return Array(suffixes.sorted { $0.numberOfMatches > $1.numberOfMatches }.filter{$0.value.count == 3}.prefix(10))
      }
   }
   
   //Set data to store
   func setSuffixData(_ text: String) {
      guard let data = try? JSONEncoder().encode(suffixModel.getSuffixes(of: text)) else { return }
      self.suffixData = data
      //Reload data to widget
      WidgetCenter.shared.reloadTimelines(ofKind: "SuffixWidget")
   }
   
   //Get data from store
   private var getSuffixData: Array<Suffix>? {
      guard let suffixes = try? JSONDecoder().decode(Array<Suffix>.self, from: suffixData) else { return nil }
      return suffixes
   }
}



enum SortType: String, Equatable, CaseIterable {
   case allABC = "All ABC" //Alphabet
   case allASC = "All ASC" //Ascending
   case allDESC = "All DESC" //Вescending
   case top = "Top 10"
   var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}
