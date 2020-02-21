//
//  HalfModalView.swift
//  HalfModal
//
//  Created by Viktor Maric on 2020. 02. 18..
//  Copyright © 2020. Viktor Maric. All rights reserved.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)

public struct HalfModalView: View {
    
//    MARK: - variables
    
    /// View which is presented by the modal. HalfModalContent is recommended to be used for it.
    var content: AnyView
    /// View which appears at the to ppart of the HalfModalView. It is optional.
    var header: AnyView?
    /// Decides whether the HalfModalView is presented.
    @Binding var isPresented: Bool
    
    /// The value of the modal's state: 0: closed, 1: half-opened, 2: opened.
    @State private var stateValue = 1
    
    /// The value of the drag.
    @GestureState private var translation: CGFloat = 0
    
    /// Opacity for the black background.
    @State private var backgroundOpacity = 0.0
    
    @State private var animation: Animation = .easeOut(duration: 0.5)
    
    public init(content: AnyView, header: AnyView?, isPresented: Binding<Bool>) {
        self.content = content
        self.header = header
        self._isPresented = isPresented
    }
    
//    MARK: - UI
    public var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                
                Color.black
                    .opacity(self.backgroundOpacity)
                
                VStack(spacing: 0) {
                    HStack {
                        self.header
                        Spacer()
                        Button(action: {
                            self.backgroundOpacity = 0.0
                            withAnimation {
                                self.isPresented = false
                            }
                        }) {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(Color(UIColor.secondarySystemFill))
                                    .font(.system(size: 31))
                                Image(systemName: "xmark")
                                    .foregroundColor(Color.secondary)
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
                    }
                    .padding()
                    
                    Divider()
                
                    self.content
                }
                .edgesIgnoringSafeArea(.all)
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
                .background(BlurView(style: .systemThickMaterial))
                .cornerRadius(15)
                .offset(y: self.stateValue == 2 ? self.translation + 50 : (self.stateValue == 1 ? geometry.size.height*0.4 + self.translation : geometry.size.height*0.7 + self.translation))
                .animation(self.animation)
                .gesture(
                    DragGesture().updating(self.$translation) { value, state, _ in
                        state = value.translation.height
                    }.onEnded { value in
                        if self.stateValue == 1 && value.translation.height < -90 {
                            self.stateValue = 2
                        } else if  self.stateValue == 1 && value.translation.height > 90 {
                            self.stateValue = 0
                            self.isPresented = false
                        } else if self.stateValue == 0 && value.translation.height < -90 {
                            self.stateValue = 1
                        } else if  self.stateValue == 0 && value.translation.height > 90 {
                            self.stateValue = 0
                            self.isPresented = false
                        } else if self.stateValue == 2 && value.translation.height > 90 && value.translation.height < 350 {
                            self.stateValue = 1
                        } else if  self.stateValue == 2 && value.translation.height >= 350 {
                            self.stateValue = 0
                            self.isPresented = false
                        }
                
                })
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        .transition(.move(edge: .bottom))
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation {
                    self.backgroundOpacity = 0.08
                }
                self.animation = .interactiveSpring()
            }
        }
        
    }
    
}
