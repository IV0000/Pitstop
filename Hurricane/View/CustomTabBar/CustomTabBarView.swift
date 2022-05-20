//
//  CustomTabBar.swift
//  Hurricane
//
//  Created by Ivan Voloshchuk on 06/05/22.
//

import SwiftUI


struct CustomTabBarView: View {
    @State var selectedIndex: Int = 0
    @StateObject var dataVM = DataViewModel()
    
    init() {
        //  CUSTOM PROPRETIES FOR ALL LISTS OF THE APP
        UITableView.appearance().separatorStyle = .singleLine
        UITableView.appearance().backgroundColor = UIColor(Palette.greyBackground)
        UITableView.appearance().separatorColor = UIColor(Palette.greyLight)
        UITableView.appearance().showsVerticalScrollIndicator = false
    }

    
    var body: some View {
        CustomTabView(tabs: TabType.allCases.map({ $0.tabItem }), selectedIndex: $selectedIndex) { index in
            let type = TabType(rawValue: index) ?? .home
            getTabView(type: type)
        }
    }
    
    @ViewBuilder
    func getTabView(type: TabType) -> some View {
        switch type {
        case .home:
            VehicleView(dataVM: dataVM)
        case .stats:
            ContentView(dataVM: dataVM)
//            AnalyticsOverviewView()
        case .settings:
            SettingsView(dataVM: dataVM)
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBarView()
    }
}


