//
//  BaseViewController.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


protocol ViewModelBindable {
    associatedtype BaseViewModelType
    var viewModel: BaseViewModelType { get }
}


class BaseViewController: UIViewController {
    
    var baseViewModel: BaseViewModel?
    
    required convenience init<T: BaseViewModel>(viewModel: T) {
        self.init(nibName: nil, bundle: nil)
        self.baseViewModel = viewModel
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        // To be overridden by sublcasses
    }
    
}
