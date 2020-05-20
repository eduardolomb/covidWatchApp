//
//  ContentView.swift
//  covidWatchApp WatchKit Extension
//
//  Created by Eduardo Lombardi on 13/05/20.
//  Copyright © 2020 Eduardo Lombardi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var fetcher = DownloadData()
    let height = CGFloat(40)
    let corner = CGFloat(5)
    let heightDivisionFactor = CGFloat(4)
    let smallFontSizeforFooter = CGFloat(10)
    
    var body: some View {
            GeometryReader { geometry in
            ScrollView() {
                if self.fetcher.globalData == nil {
                    Text("carregando...").multilineTextAlignment(.center).frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                } else {
                    Text("Dados do COVID-19").font(.system(size: 15))
                VStack {
                    RoundedRectangle(cornerRadius: self.corner).foregroundColor(.red).overlay(Text("Total de mortos: \n\(self.fetcher.globalData?.totalDeaths ?? 0)").minimumScaleFactor(0.5)).frame(idealHeight: geometry.size.height / self.heightDivisionFactor)
                    RoundedRectangle(cornerRadius: self.corner).foregroundColor(.orange).overlay(Text("Total de confirmados: \n \(self.fetcher.globalData?.totalConfirmed ?? 0)").minimumScaleFactor(0.5)).frame(idealHeight: geometry.size.height / self.heightDivisionFactor)
                    RoundedRectangle(cornerRadius: self.corner).foregroundColor(.blue).overlay(Text("Total de curados: \n \(self.fetcher.globalData?.totalRecovered ?? 0)").minimumScaleFactor(0.5)).frame(idealHeight: geometry.size.height / self.heightDivisionFactor)
                }
                 .multilineTextAlignment(.center)
                 .lineLimit(nil)
                VStack {
                    Text("Atualizado em \(self.fetcher.date, formatter: Self.taskDateFormat)")
                    Text("Dados do Centro de ciência e engenharia da universidade de Johns Hopkins").padding()
                }.multilineTextAlignment(.center).font(.system(size: self.smallFontSizeforFooter))
            }
        }
    }
}
    static let taskDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
