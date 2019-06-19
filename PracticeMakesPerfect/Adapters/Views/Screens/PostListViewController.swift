//
//  ViewController.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import RxSwift

class PostListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var postListCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    var postListViewModel: PostListViewModel!
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postListViewModel.postViewParams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let postListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostListCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        postListCollectionViewCell.set(postViewParam: postListViewModel.postViewParams[indexPath.row])
        return postListCollectionViewCell
    }
    
    override func viewDidLoad() {
        setupPostListViewModel()
        
        postListViewModel.viewLoad()
    }
    
    private func setupPostListViewModel() {
        postListViewModel.rxEventPostsLoaded
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.postListCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
}

