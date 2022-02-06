//
//  WidgetScreen.swift
//  OTUS-Dudarev-HW6
//
//  Created by Ivan Dudarev on 06.02.2022.
//

import SwiftUI

struct WidgetScreen: View {
   
   private let textInputLink = "HW06://textInputTab/"
   private let sufixLink = "HW06://sufixTab/"
   
   let suffixDescription: Array<Suffix>
   
   var body: some View {
      ZStack {
         HStack {
            // Sufix details
            VStack(alignment: .leading) {
               ForEach(suffixDescription) { suffix in
                  HStack {
                     Text(suffix.value.uppercased())
                        .bold()
                        .italic()
                     Spacer()
                     Text("\(suffix.numberOfMatches)")
                        .bold()
                        .italic()
                  }
               }
            }
            .padding()
            
            // Buttons)
            VStack {
               HStack {
                  Spacer()
                  Text("Sufix")
                     .fontWeight(.heavy)
               }
               LinkButton(url: textInputLink, text: "New text")
               LinkButton(url: sufixLink, text: "Sufix result")
            }
            .padding()
         }
         .padding()
      }
   }
}


struct LinkButton: View {
   
   let url: String
   let text: String
   
   var body: some View {
      ZStack {
         RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
         Link(destination: URL(string: url)!) {
            Text(text)
               .font(.headline)
         }
         .padding(6)
      }
   }
}
