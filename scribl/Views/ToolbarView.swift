//
//  ToolbarView.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


protocol ToolbarViewDelegate: class {
    func onEraserToggled(on: Bool)
    func onTrashPressed()
    func onColorSelected(color: UIColor)
    func onWidthSelected(width: CGFloat)
    func onPlayPressed(playing: Bool)
}


class ToolbarView: UIView {
    
    static let pickerComponentHeight: CGFloat = 24.0
    static let pickerComponentWidth: CGFloat = 44.0
    
    private var colors: [UIColor] = [.pureBlack(), .cadmiumRed(), .violetEggplant(), .yvesBlue(), .zestOrange(), .softGreen()]
    private var widths: [CGFloat] = [5, 10, 15, 20, 25]
    
    var selectedColor: UIColor = .pureBlack() {
        didSet {
            delegate?.onColorSelected(color: selectedColor)
        }
    }
    var selectedWidth: CGFloat = 5 {
        didSet {
            delegate?.onWidthSelected(width: selectedWidth)
        }
    }
    
    weak var delegate: ToolbarViewDelegate? = nil
    
    private var eraserOn: Bool = false {
        didSet {
            let eraserImage: UIImage? = eraserOn ? .eraserSelectedIcon() : .eraserIcon()
            eraserButton.setImage(eraserImage, for: .normal)
        }
    }
    
    private var playing: Bool = false {
        didSet {
            let image: UIImage? = playing ? .stopIcon() : .playIcon()
            playButton.setImage(image, for: .normal)
            delegate?.onPlayPressed(playing: playing)
        }
    }
    
    private lazy var playButton: UIButton = {
        let playButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        playButton.setImage(.playIcon(), for: .normal)
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        playButton.addTarget(self, action: #selector(playButtonPressed), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private lazy var colorPickerView: UIPickerView = {
        let pickerView = UIPickerView(frame: .zero)
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    private lazy var trashButton: UIButton = {
        let trashButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        trashButton.setImage(.trashIcon(), for: .normal)
        trashButton.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        trashButton.addTarget(self, action: #selector(trashButtonPressed), for: .touchUpInside)
        trashButton.translatesAutoresizingMaskIntoConstraints = false
        return trashButton
    }()
    
    private lazy var eraserButton: UIButton = {
        let eraserButton = UIButton(frame: CGRect(x: 0.0, y: 0.0, width: 44.0, height: 44.0))
        eraserButton.setImage(.eraserIcon(), for: .normal)
        eraserButton.imageEdgeInsets = UIEdgeInsets(top: 4.0, left: 4.0, bottom: 4.0, right: 4.0)
        eraserButton.addTarget(self, action: #selector(eraserButtonPressed), for: .touchUpInside)
        eraserButton.translatesAutoresizingMaskIntoConstraints = false
        return eraserButton
    }()
    
    convenience init() {
        self.init(frame: .zero)
        clipsToBounds = true
        configureUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureUI() {
        backgroundColor = .pureWhite()
        layer.borderColor = UIColor.pureBlack().cgColor
        layer.cornerRadius = 4.0
        layer.borderWidth = 1.0
        
        addSubview(playButton)
        playButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(colorPickerView)
        addSubview(trashButton)
        trashButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(eraserButton)
        eraserButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        NSLayoutConstraint.activate(
            [
                colorPickerView.leftAnchor.constraint(equalTo: leftAnchor, constant: Dimensions.margin16),
                colorPickerView.centerYAnchor.constraint(equalTo: centerYAnchor),
                colorPickerView.rightAnchor.constraint(equalTo: centerXAnchor),
                trashButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Dimensions.margin16),
                trashButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                eraserButton.rightAnchor.constraint(equalTo: trashButton.leftAnchor, constant: -Dimensions.margin16),
                eraserButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                playButton.rightAnchor.constraint(equalTo: eraserButton.leftAnchor, constant: -Dimensions.margin16),
                playButton.centerYAnchor.constraint(equalTo: centerYAnchor)
            ]
        )
    }
    
    @objc func eraserButtonPressed() {
        eraserOn = !eraserOn
        delegate?.onEraserToggled(on: eraserOn)
    }
    
    @objc func trashButtonPressed() {
        delegate?.onTrashPressed()
    }
    
    @objc func playButtonPressed() {
        playing = !playing
    }
    
}

extension ToolbarView: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
            case 0:
                return colors.count
            case 1:
                return widths.count
            default:
                break
        }
        return 0
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        viewForRow row: Int,
        forComponent component: Int,
        reusing view: UIView?
    ) -> UIView {
        switch component
        {
            case 0:
                let color: UIColor = colors[row]
                let view: UIView = UIView(frame:
                    CGRect(x: 0.0, y: 0.0, width: ToolbarView.pickerComponentWidth, height: ToolbarView.pickerComponentHeight)
                )
                view.backgroundColor = color
                return view
            case 1:
                let width: CGFloat = widths[row]
                let label: UILabel = UILabel(frame:
                    CGRect(x: 0.0, y: 0.0, width: ToolbarView.pickerComponentWidth, height: ToolbarView.pickerComponentHeight)
                )
                label.text = "\(width)"
                label.textColor = .pureBlack()
                label.textAlignment = .right
                return label
            default:
                break
        }
        
        return UIView()
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return ToolbarView.pickerComponentWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return ToolbarView.pickerComponentHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
            case 0:
                selectedColor = colors[row]
            case 1:
                selectedWidth = widths[row]
            default:
                break
        }
    }
    
}
