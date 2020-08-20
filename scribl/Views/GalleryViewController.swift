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
            galleryViewModel.delegate = self
            return galleryViewModel
        }
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(GalleryCell.self, forCellWithReuseIdentifier: "gallery_cell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
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
                collectionView.topAnchor.constraint(equalTo: view.topAnchor),
                collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
                collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
        
        if !UserManager.shared.userSignedIn {
            let signInViewController = SignInViewController()
            signInViewController.delegate = self
            navigationController?.present(signInViewController, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserManager.shared.userSignedIn {
            viewModel.getDrawings()
        }
    }
    
    @objc private func onDrawTapped() {
        self.navigationController?.pushViewController(
            DrawViewController.newInstance(drawViewModel: DrawViewModel(type: .create)),
            animated: true
        )
    }
    
}

extension GalleryViewController: SignInViewControllerDelegate {
    
    func onSuccessfulSignIn() {
        viewModel.getDrawings()
    }
    
}

extension GalleryViewController: GalleryViewModelDelegate {
    
    func onDrawingsLoaded() {
        self.collectionView.reloadData()
    }
    
}


extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let cellWidth: CGFloat = (collectionView.bounds.width / 2) - Dimensions.margin16
        let cellHeight: CGFloat = (cellWidth * 1.25) + (GalleryCell.labelHeight * 2)
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: Dimensions.margin8, left: Dimensions.margin8, bottom: Dimensions.margin8, right: Dimensions.margin8)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return Dimensions.margin8
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.drawings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let galleryCell: GalleryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gallery_cell", for: indexPath) as! GalleryCell
        galleryCell.canvasImageView.layer.sublayers?.removeAll()
        galleryCell.layoutIfNeeded()
        galleryCell.drawing = viewModel.drawings[indexPath.row]
        galleryCell.delegate = self
        return galleryCell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Dimensions.margin128)
    }
    
}

extension GalleryViewController: GalleryCellDelegate {
    
    func onGalleryCellClicked(drawing: Drawing) {
        self.navigationController?.pushViewController(
            DrawViewController.newInstance(drawViewModel: DrawViewModel(type: .display, drawing: drawing)),
            animated: true
        )
    }
    
}
