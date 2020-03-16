//
//  ColourUISlider.swift
//  LearningSwiftUI
//
//  Created by Kynan Song on 13/03/2020.
//  Copyright © 2020 xDesign. All rights reserved.
//

import SwiftUI

struct ColourUISlider: UIViewRepresentable {
    var colour: UIColor
    @Binding var value: Double
    
    func makeCoordinator() -> ColourUISlider.Coordinator {
        // required function
        Coordinator(value: $value)
    }
    
    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider(frame: .zero)
        slider.thumbTintColor = colour
        slider.value = Float(value)
        slider.minimumTrackTintColor = .darkGray
        slider.maximumTrackTintColor = .lightGray
        
        slider.addTarget(context.coordinator, action: #selector(Coordinator.valueChanged(_:)), for: .valueChanged)
        return slider
    }
    
    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(self.value)
    }
    
    class Coordinator: NSObject {
        var value: Binding<Double> //Reference to UISlider value
        
        init(value: Binding<Double>) {
            self.value = value
        }
        
        @objc func valueChanged(_ sender: UISlider) {
            self.value.wrappedValue = Double(sender.value)
            // value of the binding
        }
    }
}

struct ColourUISlider_Previews: PreviewProvider {
    static var previews: some View {
        ColourUISlider(colour: .red, value: .constant(0.5))
    }
}
