//
//  GraphPractice.swift
//  Hurricane
//
//  Created by Asya Tealdi on 12/05/22.
//

import SwiftUI

struct Graph: View {
    
    
    var body: some View {
        VStack {
                //if tab is fuel
            
            
                //if tab is odometer
                OdometerGraphView(data: sampleData)
                    .frame(height: 200)
                    .padding(.top, 25)
//                    .overlay(
//                        VStack {
//                            HStack {
//                                VStack(alignment: .leading) {
//                                    Text("500")
//                                    Spacer()
//                                    Text("450")
//                                    Text("350")
//                                    Text("250")
//                                    Text("150")
//                                    Spacer()
//                                    Text("0")
//                                }
//                                Spacer()
//                            }
//                            HStack(alignment: .bottom) {
//                                Text("Dec")
//                                Text("Jan")
//                                Text("Feb")
//                                Text("Mar")
//                                Text("Apr")
//                                Text("May")
//                                Text("Jun")
//                            }
//                        }
//                            .foregroundColor(Palette.greyMiddle)
//                    )
        }
    }
}

struct FuelGraphView: View {
    
    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation : CGFloat = 0
    var data: [CGFloat]
    var body: some View {
        
        HStack {
            GeometryReader { proxy in
                let height = proxy.size.height
                let width = (proxy.size.width) / CGFloat (data.count - 1)
                
                let maxPoint = (data.max() ?? 0) + 100
                
                let points = data.enumerated().compactMap { item -> CGPoint in
                    
                    let progress = item.element / maxPoint
                    
                    let pathHeight = progress * height
                    
                    let pathWidht = width * CGFloat(item.offset)
                    
                    return  CGPoint(x: pathWidht, y: -pathHeight + height)
                }
                
                ZStack{
                    
                    
                    Path { path in
                        
                        path.move(to: CGPoint(x: 0, y: 0))
                        
                        path.addLines(points)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .fill(
                        
                        LinearGradient(colors: [
                        
                            Palette.colorGreen,
                            
                           
                        ], startPoint: .leading, endPoint: .trailing)
                        
                    )
                    FillBG()
                    //Path background Color
                    .clipShape(
                        Path { path in

                            path.move(to: CGPoint(x: 0, y: 0))

                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                        }
                    )
                }
                .overlay (
                    
                    VStack(spacing: 0) {
                        Text(currentPlot)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Palette.colorGreen, in: Capsule())
                            .offset(x:  translation < 10 ? 30 : 0)
                            .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                        
                        Rectangle()
                            .fill(Palette.colorGreen)
                            .frame(width: 1, height: 40)
                            .padding(.top)
                        
                        Circle()
                            .fill(Palette.colorGreen)
                            .frame(width: 22, height: 22)
                            .overlay(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 10, height: 10)
                            )
                        
                        Rectangle()
                            .fill(Palette.colorGreen)
                            .frame(width: 1, height: 50)
                    }
                        .frame(width: 80, height: 170)
                        .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                    
                alignment: .bottomLeading
                    
                    
                )
                .contentShape(Rectangle())
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {
                        showPlot = true
                        
                        let translation = value.location.x - 40
                        
                        let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                        
                        currentPlot = "$ \(data[index])"
                        self.translation = translation
                        
                        offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                    }
                }).onEnded({ value in
                    showPlot = false
                }))
            }
//            .overlay(
//                VStack(alignment: .leading) {
//
//                    let  max = data.max() ?? 0
//
//                    Text("$ \(Int(max))")
//                        .font(.caption.bold())
//
//                    Spacer()
//
//                    Text("$ 0")
//                        .font(.caption.bold())
//                }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            )
            .padding(.horizontal, 10)
        }
        
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        LinearGradient(colors: [
        
            Palette.colorGreen
                .opacity(1),
            Palette.colorGreen
                .opacity(0.4),
            Palette.colorGreen
                .opacity(0.2),
        ] + Array(repeating: Palette.colorGreen.opacity(0.1), count: 4)
          + Array(repeating: Color.clear, count: 2),
                       startPoint: .top, endPoint: .bottom)
    }
}


struct OdometerGraphView: View {
    
    @State var currentPlot = ""
    @State var offset: CGSize = .zero
    @State var showPlot = false
    @State var translation : CGFloat = 0
    var data: [CGFloat]
    var body: some View {
        
        HStack {
            GeometryReader { proxy in
                let height = proxy.size.height
                let width = (proxy.size.width) / CGFloat (data.count - 1)
                
                let maxPoint = (data.max() ?? 0) + 100
                
                let points = data.enumerated().compactMap { item -> CGPoint in
                    
                    let progress = item.element / maxPoint
                    
                    let pathHeight = progress * height
                    
                    let pathWidht = width * CGFloat(item.offset)
                    
                    return  CGPoint(x: pathWidht, y: -pathHeight + height)
                }
                
                ZStack{
                    
                    
                    Path { path in
                        
                        path.move(to: CGPoint(x: 0, y: 0))
                        
                        path.addLines(points)
                    }
                    .strokedPath(StrokeStyle(lineWidth: 2.5, lineCap: .round, lineJoin: .round))
                    .fill(
                        
                        LinearGradient(colors: [
                        
                            Palette.blueLine,
                            
                           
                        ], startPoint: .leading, endPoint: .trailing)
                        
                    )
                    FillBG()
                    //Path background Color
                    .clipShape(
                        Path { path in

                            path.move(to: CGPoint(x: 0, y: 0))

                            path.addLines(points)
                            
                            path.addLine(to: CGPoint(x: proxy.size.width, y: height))
                            path.addLine(to: CGPoint(x: 0, y: height))
                        }
                    )
                }
                .overlay (
                    
                    VStack(spacing: 0) {
                        Text(currentPlot)
                            .font(.caption.bold())
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 10)
                            .background(Palette.blueLine, in: Capsule())
                            .offset(x:  translation < 10 ? 30 : 0)
                            .offset(x: translation > (proxy.size.width - 60) ? -30 : 0)
                        
                        Rectangle()
                            .fill(Palette.blueLine)
                            .frame(width: 1, height: 40)
                            .padding(.top)
                        
                        Circle()
                            .fill(Palette.blueLine)
                            .frame(width: 22, height: 22)
                            .overlay(
                                Circle()
                                    .fill(.white)
                                    .frame(width: 10, height: 10)
                            )
                        
                        Rectangle()
                            .fill(Palette.blueLine)
                            .frame(width: 1, height: 50)
                    }
                        .frame(width: 80, height: 170)
                        .offset(y: 70)
                    .offset(offset)
                    .opacity(showPlot ? 1 : 0),
                    
                alignment: .bottomLeading
                    
                    
                )
                .contentShape(Rectangle())
                .gesture(DragGesture().onChanged({ value in
                    withAnimation {
                        showPlot = true
                        
                        let translation = value.location.x - 40
                        
                        let index = max(min(Int((translation / width).rounded() + 1), data.count - 1), 0)
                        
                        currentPlot = "$ \(data[index])"
                        self.translation = translation
                        
                        offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                    }
                }).onEnded({ value in
                    showPlot = false
                }))
            }
//            .overlay(
//                VStack(alignment: .leading) {
//
//                    let  max = data.max() ?? 0
//
//                    Text("$ \(Int(max))")
//                        .font(.caption.bold())
//
//                    Spacer()
//
//                    Text("$ 0")
//                        .font(.caption.bold())
//                }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            )
            .padding(.horizontal, 10)
        }
        
    }
    
    @ViewBuilder
    func FillBG() -> some View {
        LinearGradient(colors: [
        
            Palette.blueLine
                .opacity(1),
            Palette.blueLine
                .opacity(0.4),
            Palette.blueLine
                .opacity(0.2),
        ] + Array(repeating: Palette.blueLine.opacity(0.1), count: 4)
          + Array(repeating: Color.clear, count: 2),
                       startPoint: .top, endPoint: .bottom)
    }
}



struct GraphPractice_Previews: PreviewProvider {
    static var previews: some View {
        Graph()
    }
}

let sampleData: [CGFloat] = [900, 400, 300, 700, 250, 150, 550, 600, 1250, 450, 550, 600,900, 400, 300, 700, 250, 150, 550, 600, 1250, 450, 550, 600,900, 400, 300, 700, 250, 150, 550, 600]