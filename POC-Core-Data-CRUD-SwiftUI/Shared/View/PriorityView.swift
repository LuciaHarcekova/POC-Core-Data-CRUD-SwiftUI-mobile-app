//
//  PriorityView.swift
//  POC-Core-Data-CRUD-SwiftUI (iOS)
//
//  Created by Lucia Harceková on 15/01/2023.
//

import SwiftUI

struct PriorityView: View {
    @Binding var priority: Int

    var label = ""
    var maximumPriority = 5

    var offImage: Image?
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow

    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }

            ForEach(1..<maximumPriority + 1, id: \.self) { number in
                image(for: number)
                    .foregroundColor(number > priority ? offColor : onColor)
                    .onTapGesture {
                        priority = number
                    }
            }
        }
    }

    func image(for number: Int) -> Image {
        if number > priority {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct PriorityView_Previews: PreviewProvider {
    static var previews: some View {
        PriorityView(priority: .constant(4))
    }
}
