//
//  ImageShowCaseWidget.swift
//  ImageShowCaseWidget
//
//  Created by Lishen Liu on 7/7/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent(), image: nil)
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration, image: nil)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let imageData = UserDefaults(suiteName: "YOUR APP GROUP NAME")?.data(forKey: "ImageShowCaseWidget")
        let uiImage = imageData != nil ? UIImage(data: imageData!) : nil

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration, image: uiImage)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
    let image: UIImage?
}

struct ImageShowCaseWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        GeometryReader { geo in
            let length = geo.size.width > geo.size.height ? geo.size.width : geo.size.height
            ZStack(alignment: .bottomLeading) {
                Image(uiImage: entry.image ?? UIImage(named: "EntryImage")!)
                // if you wish to have a default background image shown before any image being selected,
                // go to ImageShowCaseWidget/Assets, create a new image set and name it "EntryImage".
                // Then just drag any image you like into it.
                    .resizable()
                    .frame(width: length, height: length, alignment: .center)
                if entry.configuration.showDate {
                    HStack {
                        Text(entry.date.formatted(.dateTime.day()))
                        Text(entry.date.formatted(.dateTime.month()))
                    }
                    .padding()
                    .foregroundStyle(entry.configuration.fontColor ? .white : .black)
                    .bold().font(.title)
                }
            }
            .ignoresSafeArea(.all)
        }
        .padding(-20)
    }
}

struct ImageShowCaseWidget: Widget {
    let kind: String = "ImageShowCaseWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ImageShowCaseWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var showDateButton: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.showDate = true
        return intent
    }
}

#Preview(as: .systemSmall) {
    ImageShowCaseWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .showDateButton, image: nil)
}
