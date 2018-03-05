//
//  PhotoSelectorController.swift
//  VibeDating
//
//  Created by Andrew Foghel on 3/4/18.
//  Copyright © 2018 andrewfoghel. All rights reserved.
//

import UIKit
import Photos

class PhotoSelectorController: UIViewController {
    
    var images = [UIImage]()
    var selectedImage: UIImage?
    var assets = [PHAsset]()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    fileprivate func setupNavigationButtons() {
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleAddImage))
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleAddImage() {
        print("Add Image")
    }
    
    var selectedImageView = RoundImageView(color: .purple, cornerRadius: 10)
    
    fileprivate func setupViews() {
        view.addSubview(selectedImageView)
        selectedImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: nil, right: nil, bottom: nil, paddingTop: 24, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 350, height: 350)
        selectedImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(scrollView)
        scrollView.anchor(top: selectedImageView.bottomAnchor, left: selectedImageView.leftAnchor, right: selectedImageView.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingTop: 12, paddingLeft: 0, paddingRight: 0, paddingBottom: 0, width: 0, height: 0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setupNavigationButtons()
        setupViews()
        fetchPhotos()
    }
    
    func setupGrid(size: Int) {
        let step: CGFloat = CGFloat(size / 4)
        DispatchQueue.main.async {
            self.scrollView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(self.handlePan)))
            self.scrollView.contentSize.height = (step * 80) + (step * 10)
            for i in 0...size - 1 {
                let iv = RoundImageView(color: .blue, cornerRadius: 10)
                let colCount: CGFloat = CGFloat(i % 4)
                let rowCount: CGFloat = CGFloat(i / 4)
                
                iv.frame = CGRect(x: (colCount * 80) + (colCount * 10), y: (rowCount * 80) + (rowCount * 10), width: 80, height: 80)
                self.scrollView.addSubview(iv)
                iv.contentMode = .scaleAspectFill
                iv.image = self.images[i]
            
            }
        }
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        let location = gesture.location(in: scrollView)
        print(location)
    }
    
    
    
    
    fileprivate func assetFetchOptions() -> PHFetchOptions {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = 32
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        fetchOptions.sortDescriptors = [sortDescriptor]
        return fetchOptions
    }
    

    fileprivate func fetchPhotos() {
        let allPhotos = PHAsset.fetchAssets(with: .image, options: assetFetchOptions())
        DispatchQueue.global(qos: .background).async {
            allPhotos.enumerateObjects { (asset, count, stop) in
                let imageManager = PHImageManager.default()
                let targetsize = CGSize(width: 200, height: 200)
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                imageManager.requestImage(for: asset, targetSize: targetsize, contentMode: .aspectFit, options: options, resultHandler: { (image, info) in
                    if let image = image {
                        self.images.append(image)
                        self.assets.append(asset)
                    }
                })
            }
            self.setupGrid(size: self.images.count)
        }
    }
    
    
    
}

