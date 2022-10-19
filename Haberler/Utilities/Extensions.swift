//
//  Extensions.swift
//  Projects
//
//  Created by BRR on 7.08.2022.
//

import SwiftUI
import Foundation

extension Image {
    func centerCropped() -> some View {
        Color.clear
            .overlay(
                self
                    .resizable()
                    .scaledToFill()
            )
            .clipped()
    }
}

