//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    var valueSpecifier: String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        ZStack{
            Text("\(self.currentNumber, specifier: valueSpecifier)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y:-110)
                .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
            if(self.colorScheme == .dark ){
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.white, lineWidth: self.colorScheme == .dark ? 2 : 0)
                    .frame(width: 60, height: 260)
            } else {
                RoundedRectangle(cornerRadius: 16)
                    .frame(width: 60, height: 280)
                    .foregroundColor(Color.white)
                    .shadow(color: Colors.LegendText, radius: 12, x: 0, y: 6 )
                    .blendMode(.multiply)
            }
        }
        .offset(x: 0, y: -15)
    }
}

struct LineIndicator: View {
    @Binding var touchOffset: CGFloat
    @Binding var currentNumber: Double
    @State private var textSize: CGSize = .zero
    var valueSpecifier: String
    var graphWidth: CGFloat
    var color: Color = .black
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    public var body: some View {
        GeometryReader { reader in
            VStack {
                Text("\(self.currentNumber, specifier: valueSpecifier)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(self.colorScheme == .dark ? Color.white : Color.black)
                    .background(ViewGeometry())
                    .onPreferenceChange(ViewSizeKey.self) {
                        textSize = $0
                    }
                    .offset(x: textOffset(touchLocationX: touchOffset,
                                          textWidth: textSize.width,
                                          frameWidth: graphWidth),
                            y: 0)
                Path() { path in
                    path.move(to: CGPoint(x: reader.frame(in: .local).width/2, y: 0))
                    path.addLine(to: CGPoint(x: reader.frame(in: .local).width/2, y: reader.frame(in: .local).height))
                }
                .stroke(color, style: StrokeStyle(lineWidth: 2, dash: [3]))
            }
            .offset(x: stickyOffset(touchLocationX: touchOffset, frameWidth: reader.frame(in: .local).width/2), y: -15)
    }
}

func stickyOffset(touchLocationX: CGFloat, frameWidth: CGFloat) -> CGFloat {
    min(frameWidth, max(-frameWidth, touchLocationX))
    }
    
    func textOffset(touchLocationX: CGFloat, textWidth: CGFloat, frameWidth: CGFloat) -> CGFloat {
        if (touchLocationX < (-frameWidth/2 + textWidth/2)) {
            return min((-frameWidth/2 + textWidth/2) - touchLocationX, textWidth/2)
        } else if (touchLocationX > (frameWidth/2 - textWidth/2)) {
            return max((frameWidth/2 - textWidth/2) - touchLocationX, -textWidth/2)
        } else {
            return 0
        }
    }
}
