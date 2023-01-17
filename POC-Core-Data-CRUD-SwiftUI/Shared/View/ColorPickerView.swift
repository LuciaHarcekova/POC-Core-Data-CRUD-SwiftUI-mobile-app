//
//  ColorPickerView.swift
//  POC-Core-Data-CRUD-SwiftUI
//
//  Created by Lucia Harceková on 14/01/2023.
//

import SwiftUI

struct ColorPickerView: View {
    
    @Binding var color: Color
    
    var body: some View {
        VStack {
            ColorPicker("Choose a background color", selection: $color)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView(color: .constant(Color.clear))
    }
}
