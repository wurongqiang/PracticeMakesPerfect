//
//  ViewController.swift
//  SearchFilter
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import RxSwift
import SegueManager

class ProductListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, SeguePerformer {
    
    @IBOutlet weak var productListCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    var productListViewModel: ProductListViewModel!
    
    override func viewDidLoad() {
        setupProductListViewModel()
        
        initSegueManagerObject()
        registerCollectionViewCellNib()
        productListViewModel.viewLoad()
    }

    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width / 2, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productListViewModel.productViewParams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let productListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
        productListCollectionViewCell.set(productViewParam: productListViewModel.productViewParams[indexPath.row])
        return productListCollectionViewCell
    }
    
    // MARK: - Segue
    
    private var segueManagerObject: SegueManager?
    
    var segueManager: SegueManager {
        guard let segueManagerObject = segueManagerObject else { return SegueManager(viewController: UIViewController()) }
        return segueManagerObject
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        segueManager.prepare(for: segue)
    }
    
    private func initSegueManagerObject() {
        segueManagerObject = SegueManager(viewController: self)
    }
    
    // MARK: - Private

    private func registerCollectionViewCellNib() {
        let nib = UINib(resource: R.nib.productCollectionViewCell)
        productListCollectionView.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
    
    private func setupProductListViewModel() {
            productListViewModel.rxEventProductsLoaded
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.productListCollectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}

