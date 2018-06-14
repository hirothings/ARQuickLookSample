//
//  ViewController.swift
//  ARQuickLookSample
//
//  Created by hirothings on 2018/06/12.
//  Copyright © 2018年 hirothings. All rights reserved.
//

import UIKit
import QuickLook

class ViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let items: [Item] = [
        Item(name: "gramophone"),
        Item(name: "trowel"),
        Item(name: "teapot"),
        Item(name: "wheelbarrow"),
        Item(name: "retrotv"),
        Item(name: "wateringcan")
    ]

    private var selectedIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
    }

    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        let flowLayout = UICollectionViewFlowLayout()
        let size = self.view.frame.width / 3
        flowLayout.itemSize = CGSize(width: size, height: size)
        flowLayout.minimumLineSpacing = .leastNormalMagnitude
        flowLayout.minimumInteritemSpacing = .leastNormalMagnitude
        collectionView.collectionViewLayout = flowLayout
    }
}

extension ViewController: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        // Viewer supports previewing a single 3D object
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let fileUrl = Bundle.main.url(forResource: items[selectedIndex].name, withExtension: "usdz")!
        return fileUrl as QLPreviewItem
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.configure(with: items[indexPath.row])
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previewController = QLPreviewController()
        previewController.dataSource = self
        selectedIndex = indexPath.row
        present(previewController, animated: true, completion: nil)
    }
}

