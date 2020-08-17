//
//  DrawViewController.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


class DrawViewController: BaseViewController {
    
    private lazy var canvasView: CanvasView = {
        let canvasView = CanvasView()
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    
    private lazy var toolbarView: ToolbarView = {
        let toolbarView = ToolbarView()
        toolbarView.delegate = self
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        return toolbarView
    }()
    
    override func configureUI() {
        title = "Draw"
        view.backgroundColor = .pureWhite()
        
        view.addSubview(toolbarView)
        view.addSubview(canvasView)
        
        NSLayoutConstraint.activate(
            [
                toolbarView.leftAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leftAnchor,
                    constant: Dimensions.margin32
                ),
                toolbarView.topAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.topAnchor,
                    constant: Dimensions.margin32
                ),
                toolbarView.rightAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.rightAnchor,
                    constant: -Dimensions.margin32
                ),
                toolbarView.heightAnchor.constraint(equalToConstant: Dimensions.toolbarHeight),
                canvasView.leftAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.leftAnchor,
                    constant: Dimensions.margin32
                ),
                canvasView.topAnchor.constraint(
                    equalTo: toolbarView.bottomAnchor,
                    constant: Dimensions.margin32
                ),
                canvasView.rightAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.rightAnchor,
                    constant: -Dimensions.margin32
                ),
                canvasView.bottomAnchor.constraint(
                    equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                    constant: -Dimensions.margin32
                )
            ]
        )
        
    }
    
}

extension DrawViewController: ToolbarViewDelegate {
    
    func onEraserToggled(on: Bool) {
        canvasView.strokeColor = on ? .pureWhite() : toolbarView.selectedColor
    }
    
    
}
