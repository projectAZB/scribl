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
    
    var displayRendered: Bool = false
    
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
        if viewModel.type == .display {
            canvasView.editable = false
        }
        canvasView.translatesAutoresizingMaskIntoConstraints = false
        return canvasView
    }()
    
    private lazy var toolbarView: ToolbarView = {
        let toolbarView = ToolbarView(type: viewModel.type)
        toolbarView.delegate = self
        toolbarView.translatesAutoresizingMaskIntoConstraints = false
        return toolbarView
    }()
    
    override func configureUI() {
        title = "Canvas"
        view.backgroundColor = .pureWhite()
        
        if viewModel.type == .display &&
            viewModel.drawing.email.lowercased() == UserManager.shared.userEmail!.lowercased() {
            let button = UIBarButtonItem(
                image: .trashIcon(),
                style: UIBarButtonItem.Style.plain,
                target: self,
                action: #selector(onDeletePressed)
            )
            navigationItem.rightBarButtonItem = button
        }
        else if viewModel.type == .create {
            let button = UIBarButtonItem(
                image: .saveIcon(),
                style: UIBarButtonItem.Style.plain,
                target: self,
                action: #selector(onSavePressed)
            )
            navigationItem.rightBarButtonItem = button
        }
        
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if viewModel.type == .display && !displayRendered {
            canvasView.render(drawing: viewModel.drawing)
            displayRendered = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        canvasView.cleanup()
    }
    
    @objc func onSavePressed() {
        guard viewModel.drawing.strokes.count > 0 else {
            // Not a valid drawing since there are no strokes, show error
            self.present(
                ErrorAlertFactory.create(message: "No drawing to save, try adding some strokes"),
                animated: true,
                completion: nil
            )
            return
        }
        viewModel.saveDrawing()
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onDeletePressed() {
        viewModel.deleteDrawing()
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
        // No matter what, if it's in `display` mode, turn userinteraction off
        if viewModel.type == .display {
            canvasView.isUserInteractionEnabled = false
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
