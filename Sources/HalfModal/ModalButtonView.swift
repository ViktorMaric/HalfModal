//
//  ModalButtonView.swift
//  HalfModal
//
//  Created by Viktor Maric on 2020. 02. 19..
//  Copyright © 2020. Viktor Maric. All rights reserved.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)

public struct ModalButtonView: View {
    
    public init(title: String, image: Image, labelColor: Color) {
        self.title = title
        self.image = image
        self.labelColor = labelColor
    }
    
    var title: String
    var image: Image
    var labelColor: Color
    
    public var body: some View {
        
        HStack {
            Text(title)
                 .font(.system(size: 17))
            Spacer()
            image
                .font(.system(size: 21))
        }
        .accentColor(labelColor)
        
    }
    
}
