//
//  CastButtonRepresentable.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/22/22.
//

import SwiftUI
import GoogleCast

struct CastButton: View {
    var body: some View {
        CastButtonRepresentable()
            .frame(width: 40, height: 40, alignment: .center)
    }
}

struct CastButtonRepresentable: UIViewRepresentable {
  
    func makeUIView(context: Context) -> some UIView {
        let castButton = GCKUICastButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        castButton.tintColor = .gray
        
        return castButton
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}





struct CastButton_Previews: PreviewProvider {
    static var previews: some View {
        CastButton()
    }
}
