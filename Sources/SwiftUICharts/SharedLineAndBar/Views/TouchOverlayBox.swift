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
internal struct TouchOverlayBox<T: CTChartData>: View {
    
    @ObservedObject private var chartData: T
    
    @Binding private var boxFrame: CGRect
    
    internal init(
        chartData: T,
        boxFrame: Binding<CGRect>
    ) {
        self.chartData = chartData
        self._boxFrame = boxFrame
    }
    
    internal var body: some View {
        Group {
            if chartData.chartStyle.infoBoxContentAlignment == .vertical {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(chartData.infoView.touchOverlayInfo, id: \.id) { point in
                        HStack {
                            chartData.infoLegend(info: point)
                                .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                            Text("-") // You can adjust this as needed to get the dash you want
                            chartData.infoValueUnit(info: point)
                                .font(chartData.chartStyle.infoBoxValueFont)
                                .foregroundColor(chartData.chartStyle.infoBoxValueColour)
                            //Text("issues")
                        }
                            chartData.infoDescription(info: point)
                                .font(chartData.chartStyle.infoBoxDescriptionFont)
                                .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                                .padding(.leading,20)                                           
                    }
                }
            } else {
                HStack {
                    ForEach(chartData.infoView.touchOverlayInfo, id: \.id) { point in
                        chartData.infoLegend(info: point)
                            .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                            .layoutPriority(1)
                        chartData.infoDescription(info: point)
                            .font(chartData.chartStyle.infoBoxDescriptionFont)
                            .foregroundColor(chartData.chartStyle.infoBoxDescriptionColour)
                        chartData.infoValueUnit(info: point)
                            .font(chartData.chartStyle.infoBoxValueFont)
                            .foregroundColor(chartData.chartStyle.infoBoxValueColour)
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
