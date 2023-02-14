//
//  Statistics.swift
//  ToDoScamList
//
//  Created by Denis Zhesterev on 26.01.2023.
//

import SwiftUI
import SwiftUICharts

struct Statistics: View {
    @Binding var type: String
    @Binding var allPower: Double
    @Binding var averagePowerOfAll: Double
    @Binding var averagePowerSameType: Double
    @Binding var averagePowerOfLast30day: Double
    @Binding var mostFrequentTypeCount: Int
    @Binding var mostFrequentType: String
    @Binding var sameTypeCount: Int
    @Binding var last30dayPower: Int
    @Binding var last30daySameTypeCount: Int
    @Binding var currentWeekSameTypeCount: Int
    @Binding var currentWeekPower: Int
    @Binding var oneWeekAgoPower: Int
    @Binding var twoWeeksAgoPower: Int
    @Binding var threeWeeksAgoPower: Int
    @Binding var fourWeeksAgoPower: Int
    @Binding var fiveWeeksAgoPower: Int
    @Binding var eachTypeCount: [Int]
    @Binding var allTypes: [String]
    @State private var statistic = false
    @State private var general = false
    @State private var month = false
    @State private var week = false
    @Environment(\.presentationMode) var presentationMode
    let today = Date.todayDate
    let lastSunday = Date.lastSunday
    let oneSundayAgo = Date.oneSundayAgo
    let twoSundayAgo = Date.twoSundayAgo
    let threeSundayAgo = Date.threeSundayAgo
    let fourSundayAgo = Date.fourSundayAgo
    let fiveSundayAgo = Date.fiveSundayAgo
    let lastMonday = Date.lastMonday
    let oneMondayAgo = CalendarWeeksAgo().oneWeekAgoDate.getFormattedDate(format: "dd/MM")
    let twoMondayAgo = CalendarWeeksAgo().twoWeeksAgoDate.getFormattedDate(format: "dd/MM")
    let threeMondayAgo = CalendarWeeksAgo().threeWeeksAgoDate.getFormattedDate(format: "dd/MM")
    let fourMondayAgo = CalendarWeeksAgo().fourWeeksAgoDate.getFormattedDate(format: "dd/MM")
    let fiveMondayAgo = CalendarWeeksAgo().fiveWeeksAgoDate.getFormattedDate(format: "dd/MM")
    let screenSize = UIScreen.main.bounds
    let pieChartStyle = ChartStyle(backgroundColor: .black, accentColor: .orange, gradientColor: GradientColor(start: .orange, end: .red), textColor: .white, legendTextColor: .white, dropShadowColor: .gray)
    func findPieChartData() -> [PieChartData] {
        var pieChartData = [PieChartData]()
        var item = 0
        repeat {
            pieChartData.append(PieChartData(label: allTypes[item], value: Double(eachTypeCount[item])))
            item += 1
        }
        while allTypes.count > item
                return pieChartData
    }
    var body: some View {
        NavigationView {
        List {
            HStack {
                Group {
                    Text("Количество скамов типа ")
                        .font(.system(size: 18, weight: .bold, design: .default))
                    + Text("#\(type)")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.orange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text("\(sameTypeCount)")
                        .medium14()
                }
                .frame(alignment: .trailing)
            }
            HStack {
                Group {
                    Text("Средняя сила типа ")
                        .font(.system(size: 18, weight: .bold, design: .default))
                    + Text("#\(type)")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .foregroundColor(.orange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text(String(format: "%.2f", averagePowerSameType))
                        .medium14()
                }
                .frame(alignment: .trailing)
            }
            DisclosureGroup(isExpanded: $general, content: {
                ZStack {
                    Text("Общая сила скама")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("\(Int(allPower))")
                            .medium14()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                ZStack {
                    Text("Средняя сила")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text(String(format: "%.2f", averagePowerOfAll))
                            .medium14()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                ZStack {
                    VStack(alignment: .leading, spacing: 60) {
                        Text("Самый популярный тип:")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .padding(0)
                        Text("Встречается")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .padding(0)
                            .offset(y: -7)
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text(mostFrequentType)
                            .medium14()
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .offset(y: 22.5)
                        Text("\(mostFrequentTypeCount)")
                            .medium14()
                            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .bottomTrailing)
                    }
                }
            }, label: {Text("За все время").font(.system(size: 18, weight: .bold, design: .default))})
            DisclosureGroup(isExpanded: $month, content: {
                ZStack {
                    Text("Общая сила")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("\(last30dayPower)")
                            .medium14()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Group {
                        Text("Количество скамов типа ")
                            .font(.system(size: 14, weight: .medium, design: .default))
                        + Text("#\(type)")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.orange)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("\(last30daySameTypeCount)")
                            .medium14()
                    }
                    .frame(alignment: .trailing)
                }
                ZStack {
                    Text("Средняя сила")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text(String(format: "%.2f", averagePowerOfLast30day))
                            .medium14()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }, label: {Text("За месяц").font(.system(size: 18, weight: .bold, design: .default))})
            DisclosureGroup(isExpanded: $week, content: {
                ZStack {
                    Text("Общая сила")
                        .font(.system(size: 14, weight: .medium, design: .default))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("\(currentWeekPower)")
                            .medium14()
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                HStack {
                    Group {
                        Text("Количество скамов типа ")
                            .font(.system(size: 14, weight: .medium, design: .default))
                        + Text("#\(type)")
                            .font(.system(size: 14, weight: .medium, design: .default))
                            .foregroundColor(.orange)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        Text("\(currentWeekSameTypeCount)")
                            .medium14()
                    }
                    .frame(alignment: .trailing)
                }
            }, label: {Text("Текущая неделя").font(.system(size: 18, weight: .bold, design: .default))})
            VStack {
                BarChartView(data: ChartData(values: [("\(fiveMondayAgo) - \(fourSundayAgo)", Double(fiveWeeksAgoPower)), ("\(fourMondayAgo) - \(threeSundayAgo)", Double(fourWeeksAgoPower)), ("\(threeMondayAgo) - \(twoSundayAgo)", Double(threeWeeksAgoPower)), ("\(twoMondayAgo) - \(oneSundayAgo)", Double(twoWeeksAgoPower)), ("\(oneMondayAgo) - \(lastSunday)", Double(oneWeekAgoPower)), ("\(lastMonday) - \(today)", Double(currentWeekPower))]), title: "Общая сила", legend: "за последние недели", style: Styles.barChartStyleOrangeLight, form: CGSize(width: screenSize.width * 0.8, height: 200))
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .bottom)
                PieChartView(data: findPieChartData(), title: "Типы скамов", style: pieChartStyle, form: CGSize(width: screenSize.width * 0.8, height: 300))
                    .padding(.top, 15)
                    .frame(maxWidth: .infinity, alignment: .bottom)
            }
            
        }
        .navigationBarTitle("Статистика")
        .navigationBarItems(leading: Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Image(systemName: "chevron.left")
                .backButton()
        }, trailing: Text(type))
    }
        .environment(\.colorScheme, .dark)
    }
}

struct Statistics_Previews: PreviewProvider {
    static var previews: some View {
        Statistics(type: .constant(""), allPower: .constant(0.0), averagePowerOfAll: .constant(0.0), averagePowerSameType: .constant(0.0), averagePowerOfLast30day: .constant(0.0), mostFrequentTypeCount: .constant(0), mostFrequentType: .constant(""), sameTypeCount: .constant(0), last30dayPower: .constant(0), last30daySameTypeCount: .constant(0), currentWeekSameTypeCount: .constant(0), currentWeekPower: .constant(0), oneWeekAgoPower: .constant(0), twoWeeksAgoPower: .constant(0), threeWeeksAgoPower: .constant(0), fourWeeksAgoPower: .constant(0), fiveWeeksAgoPower: .constant(0), eachTypeCount: .constant([0]), allTypes: .constant([""]))
    }
}
