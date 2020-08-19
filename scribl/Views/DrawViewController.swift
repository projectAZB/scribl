//
//  DrawViewController.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


class DrawViewController: BaseViewController, ViewModelBindable {
    
    var viewModel: DrawViewModel {
        get {
            guard let drawViewModel: DrawViewModel = baseViewModel as? DrawViewModel else {
                fatalError("ViewModel isn't a DrawViewModel")
            }
            return drawViewModel
        }
    }
    
    static func newInstance(drawViewModel: DrawViewModel) -> DrawViewController {
        return DrawViewController(viewModel: drawViewModel)
    }
    
    private lazy var canvasView: CanvasView = {
        let canvasView = CanvasView()
        canvasView.delegate = self
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
        title = "Canvas"
        view.backgroundColor = .pureWhite()
        
        let button = UIBarButtonItem(
            image: .saveIcon(),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(onSavePressed)
        )
        navigationItem.rightBarButtonItem = button
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        canvasView.cleanup()
    }
    
    @objc func onSavePressed() {
        viewModel.saveDrawing()
        navigationController?.popViewController(animated: true)
    }
    
}

extension DrawViewController: CanvasViewDelegate {
    
    func onPlayDrawingEnded() {
        toolbarView.playButtonPressed()
    }
    
    
    func onStrokeEnded(stroke: Stroke) {
        viewModel.drawing.addStroke(stroke)
    }
    
}

extension DrawViewController: ToolbarViewDelegate {
    
    func onPlayPressed(playing: Bool) {
        canvasView.playing = playing
        if playing {
            canvasView.playDrawing(viewModel.drawing)
        }
    }
    
    func onEraserToggled(on: Bool) {
        canvasView.strokeColor = on ? .pureWhite() : toolbarView.selectedColor
    }
    
    func onTrashPressed() {
        canvasView.resetDrawing()
        viewModel.drawing.reset()
    }
    
    func onColorSelected(color: UIColor) {
        canvasView.strokeColor = color
    }
    
    func onWidthSelected(width: CGFloat) {
        canvasView.strokeWidth = width
    }
    
}
