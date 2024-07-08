//
//  AppIntent.swift
//  ImageShowCaseWidget
//
//  Created by Lishen Liu on 7/7/24.
//

import WidgetKit
import AppIntents

struct ConfigurationAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configuration"
    static var description = IntentDescription("A widget that shows selected photo")

    @Parameter(title: "Show Date", default: true)
    var showDate: Bool
    @Parameter(title: "White Font", default: true)
    var fontColor: Bool
}
