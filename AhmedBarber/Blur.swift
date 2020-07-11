//
//  Blur.swift
//  AhmedBarber
//
//  Created by Nicolas Lucchetta on 30/06/2020.
//  Copyright © 2020 NLCompany. All rights reserved.
//

import SwiftUI

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .regular
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
