//
//  GalleryViewController.swift
//  scribl
//
//  Created by Adam Bollard on 8/16/20.
//  Copyright © 2020 Adam Bollard. All rights reserved.
//

import Foundation
import UIKit


class GalleryViewController: BaseViewController, ViewModelBindable {
    
    var viewModel: GalleryViewModel {
        get {
            guard let galleryViewModel = baseViewModel as? GalleryViewModel else {
                fatalError("ViewModel isn't a GalleryViewModel")
            }
            return galleryViewModel
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func configureUI() {
        title = "Gallery"
        
        let button = UIBarButtonItem(
            image: .drawIcon(),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(onDrawTapped)
        )
        navigationItem.rightBarButtonItem = button
        
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate(
            [
                collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    @objc private func onDrawTapped() {
        self.navigationController?.pushViewController(
            DrawViewController.newInstance(drawViewModel: DrawViewModel()),
            animated: true
        )
    }
    
}


extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drawings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
}
