//
//  VideoControlRepresentable.swift
//  VideoCaster
//
//  Created by Oscar Castillo on 10/24/22.
//

import SwiftUI
import GoogleCast

struct VideoControlView: View {
    var body: some View {
        VideoControlRepresentable()
            .frame(width: 300, height: 300, alignment: .center)
    }
}

struct VideoControlRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        VideoControlView()
    }
}

struct VideoControlRepresentable: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: PlayerViewController, context: Context) {
        
    }

    typealias UIViewControllerType = PlayerViewController
    
    func makeUIViewController(context: Context) -> PlayerViewController {
        let viewController = PlayerViewController()
        let castContext = GCKCastContext.sharedInstance()
        var miniMediaControlsViewController: GCKUIMiniMediaControlsViewController
        miniMediaControlsViewController = castContext.createMiniMediaControlsViewController()
        miniMediaControlsViewController.delegate = viewController
        viewController.view.addSubview(miniMediaControlsViewController.view)
        
        return viewController
    }
}

