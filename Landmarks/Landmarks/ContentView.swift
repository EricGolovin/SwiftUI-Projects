//
//  ContentView.swift
//  Landmarks
//
//  Created by Eric Golovin on 23.08.2020.
//  Copyright © 2020 Eric Golovin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turtle Rock")
                .font(.largeTitle)
            HStack {
                Text("Joshua Tree National Park")
                Spacer()
                Text("California")
            }
            .font(.subheadline)
        }
        .padding()
        
            
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
 