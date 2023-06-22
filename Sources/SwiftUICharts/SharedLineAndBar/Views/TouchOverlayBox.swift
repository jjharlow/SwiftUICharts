//
//  TouchOverlayBox.swift
//  LineChart
//
//  Created by Will Dale on 09/01/2021.
//

import SwiftUI

/**
 View that displays information from the touch events.
 6/22/2023 - changed order of infobox items
 */
    internal var body: some View {
        Group {
            if chartData.chartStyle.infoBoxContentAlignment == .vertical {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(chartData.infoView.touchOverlayInfo, id: \.id) { point in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(point.validationTitle): \(point.value)") // Assuming point.validationTitle and point.value are strings
                                    .font(chartData.chartStyle.infoBoxDescriptionFont)
                                    .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                                Spacer()
                            }
                            Text(point.description)
                                .font(chartData.chartStyle.infoBoxDescriptionFont)
                                .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                        }
                    }
                }
            } else {
                HStack {
                    ForEach(chartData.infoView.touchOverlayInfo, id: \.id) { point in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("\(point.validationTitle): \(point.value)") // Assuming point.validationTitle and point.value are strings
                                    .font(chartData.chartStyle.infoBoxDescriptionFont)
                                    .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                                Spacer()
                            }
                            Text(point.description)
                                .font(chartData.chartStyle.infoBoxDescriptionFont)
                                .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                        }
                    }
                }
            }
        }
        .padding(.all, 8)
        .background(
            GeometryReader { geo in
                if chartData.infoView.isTouchCurrent {
                    RoundedRectangle(cornerRadius: 5.0, style: .continuous)
                        .fill(chartData.chartStyle.infoBoxBackgroundColour)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5.0, style: .continuous)
                                .stroke(chartData.chartStyle.infoBoxBorderColour, style: chartData.chartStyle.infoBoxBorderStyle)
                        )
                        .onAppear {
                            self.boxFrame = geo.frame(in: .local)
                        }
                        .onChange(of: geo.frame(in: .local)) { frame in
                            self.boxFrame = frame
                        }
                }
            }
        )
    }
}
