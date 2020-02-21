//
//  HalfModalContent.swift
//  HalfModal
//
//  Created by Viktor Maric on 2020. 02. 19..
//  Copyright © 2020. Viktor Maric. All rights reserved.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)

public struct HalfModalContent: View {
    
//    MARK: - variables
    var priorButtons: [AnyView]?
    var secondaryButtons: [AnyView]?
    
    public init(priorButtons: [AnyView]?, secondaryButtons: [AnyView]?) {
        self.priorButtons = priorButtons
        self.secondaryButtons = secondaryButtons
    }
    
//    MARK: - UI
    public var body: some View {
        
        GeometryReader { geometry in
            VStack {
                
                if self.priorButtons != nil {
                    VStack {
                        ForEach(0 ..< self.priorButtons!.count, id: \.self) { priorButtonIndex in
                            VStack {
                                self.priorButtons![priorButtonIndex]
                                    .padding(.horizontal)
                                    .padding(.top, self.getPaddingValue(index: priorButtonIndex))
                                    .padding(.bottom, 4)
                                if priorButtonIndex != self.priorButtons!.count - 1 {
                                    Color.primary
                                        .frame(height: 0.5)
                                        .opacity(0.2)
                                } else {
                                    Color.clear
                                        .frame(height: 0.5)
                                        .opacity(0.2)
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width*0.9)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(8)
                    .padding(.vertical)
                }
                
                if self.secondaryButtons != nil {
                    VStack {
                        ForEach(0 ..< self.secondaryButtons!.count, id: \.self) { secondaryButtonIndex in
                            VStack {
                                self.secondaryButtons![secondaryButtonIndex]
                                    .padding(.horizontal)
                                    .padding(.top, self.getPaddingValue(index: secondaryButtonIndex))
                                    .padding(.bottom, 4)
                                if secondaryButtonIndex != self.secondaryButtons!.count - 1 {
                                    Color.primary
                                        .frame(height: 0.5)
                                        .opacity(0.2)
                                } else {
                                    Color.clear
                                        .frame(height: 0.5)
                                        .opacity(0.2)
                                }
                            }
                        }
                    }
                    .frame(width: geometry.size.width*0.9)
                    .background(Color(UIColor.tertiarySystemBackground))
                    .cornerRadius(8)
                    .padding(.vertical)
                }
                
                Spacer()
            }
        }

    }
    
    private func getPaddingValue(index: Int) -> CGFloat {
//        return index != self.priorButtons!.count - 1 ? 8 : 0
        return index != 0 ? 8 : 14
    }
    
}
