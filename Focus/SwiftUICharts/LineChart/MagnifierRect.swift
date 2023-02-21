//
//  MagnifierRect.swift
//  
//
//  Created by Samu András on 2020. 03. 04..
//

import SwiftUI

public struct MagnifierRect: View {
    @Binding var currentNumber: Double
    var valueSpecifier:String
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    public var body: some View {
        ZStack{
            Text("\(self.currentNumber, specifier: valueSpecifier)")
                .font(.system(size: 18, weight: .bold))
                .offset(x: 0, y:-110)
                .foregroundColor(Color("black"))
          
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 60, height: 280)
                .foregroundColor(.white)
                .shadow(color: Color("black"), radius: 12, x: 0, y: 6 )
                .blendMode(.multiply)
        
        }
        .offset(x: 0, y: -15)
    }
}
