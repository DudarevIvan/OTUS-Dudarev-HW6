//
//  SuffixWidget.swift
//  SuffixWidget
//
//  Created by Ivan Dudarev on 06.02.2022.
//

//import WidgetKit
//import SwiftUI
//import Intents
//
//struct Provider: IntentTimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
//    }
//
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(), configuration: configuration)
//        completion(entry)
//    }
//
//    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for hourOffset in 0 ..< 5 {
//            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, configuration: configuration)
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
//}
//
//struct SimpleEntry: TimelineEntry {
//    let date: Date
//    let configuration: ConfigurationIntent
//}
//
//struct SuffixWidgetEntryView : View {
//    var entry: Provider.Entry
//
//    var body: some View {
//        Text(entry.date, style: .time)
//    }
//}
//
//@main
//struct SuffixWidget: Widget {
//    let kind: String = "SuffixWidget"
//
//    var body: some WidgetConfiguration {
//        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
//            SuffixWidgetEntryView(entry: entry)
//        }
//        .configurationDisplayName("My Widget")
//        .description("This is an example widget.")
//    }
//}
//
//struct SuffixWidget_Previews: PreviewProvider {
//    static var previews: some View {
//        SuffixWidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
//            .previewContext(WidgetPreviewContext(family: .systemSmall))
//    }
//}


import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    //Storage
    @AppStorage("suffixData", store: UserDefaults(suiteName: "group.dudarev-group"))
    var suffixData: Data = .init()
    
    func placeholder(in context: Context) -> SimpleEntry {
      let suffixDescription: Suffix = .init(id: 0, value: "Suffix", numberOfMatches: 0)
        let suffixArray = Array<Suffix>(repeating: suffixDescription, count: 4)
        return SimpleEntry(date: Date(), suffixDescription: suffixArray)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        guard let suffixDescriptionArray = try? JSONDecoder().decode(Array<Suffix>.self, from: suffixData) else { return }
        let entry = SimpleEntry(date: Date(), suffixDescription: suffixDescriptionArray)
        completion(entry)
    }
   
   func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
      var entries: [SimpleEntry] = []
      
      let currentDate = Date()
      for hourOffset in 0 ..< 5 {
         guard let suffixDescriptionArray = try? JSONDecoder().decode(Array<Suffix>.self, from: suffixData) else { return }
         let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
         //Only first five elements (3 char)
         let entry = SimpleEntry(date: entryDate, suffixDescription: Array(suffixDescriptionArray.filter{$0.value.count == 3}.sorted { $0.numberOfMatches > $1.numberOfMatches }.prefix(5)))
         entries.append(entry)
      }
      
      let timeline = Timeline(entries: entries, policy: .never)
      completion(timeline)
   }
}


struct SimpleEntry: TimelineEntry {
    var date = Date()
    var suffixDescription: [Suffix]
}


struct SuffixWidgetEntryView : View {
    
    var entry: Provider.Entry
    
    var body: some View {
        WidgetScreen(suffixDescription: entry.suffixDescription)
    }
}


@main
struct SuffixWidget: Widget {
    let kind: String = "SuffixWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            SuffixWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Suffix Widget")
        .description("This is a sufix widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct SuffixWidget_Previews: PreviewProvider {
    static var previews: some View {
      let widget = [Suffix(id: 0, value: "Suffix", numberOfMatches: 1), Suffix(id: 1, value: "Suffix2", numberOfMatches: 2)]
      SuffixWidgetEntryView(entry: SimpleEntry(date: Date(), suffixDescription: widget))
         .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
