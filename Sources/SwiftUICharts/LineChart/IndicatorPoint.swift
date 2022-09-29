//
//  IndicatorPoint.swift
//  LineChart
//
//  Created by András Samu on 2019. 09. 03..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

struct IndicatorPoint: View {
    var color: Color
    
    var body: some View {
        ZStack(alignment: .center, content: {
            Circle()
                .size(CGSize(width: 14, height: 14))
                .fill(.white)
            Circle()
                .size(CGSize(width: 8, height: 8))
                .fill(color)
                .offset(x: 3, y: 3)
            Circle()
                .size(CGSize(width: 14, height: 14))
                .stroke(color, style: StrokeStyle(lineWidth: 1))
            
        })
        .frame(width: 16, height: 16)
    }
}

struct IndicatorPoint_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorPoint(color: .black)
    }
}
