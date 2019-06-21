//
//  ViewController.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import RxSwift
import SegueManager

class PostListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, PostListViewModelProtocol, SeguePerformer {
    
    @IBOutlet weak var postListCollectionView: UICollectionView!
    
    private let disposeBag = DisposeBag()
    
    var postListViewModel: PostListViewModel!
    
    override func viewDidLoad() {
        setupPostListViewModel()
        
        initSegueManagerObject()
        registerCollectionViewCellNib()
        postListViewModel.viewLoad()
    }

    // MARK: - CollectionView
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openPost(postViewParam: postListViewModel.postViewParams[indexPath.row])
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

    private func openPost(postViewParam: PostViewParam) {
        performSegue(withIdentifier: R.segue.postListViewController.showPost) { segue in
            let destinationViewController = segue.destination
            destinationViewController.postDetailViewModel.postViewParam = postViewParam
        }
    }
    
    // MARK: - PostListViewModel
    
    func delegatePostsLoaded() {
        print("POSTS LOADED")
    }
    
    // MARK: - Private

    private func registerCollectionViewCellNib() {
        let nib = UINib(resource: R.nib.postCollectionViewCell)
        postListCollectionView.register(nib, forCellWithReuseIdentifier: "PostListCollectionViewCell")
    }
    
    private func setupPostListViewModel() {
            postListViewModel.delegate = self
            postListViewModel.rxEventPostsLoaded
            .subscribe(onNext: { [weak self] in
                guard let weakSelf = self else { return }
                weakSelf.postListCollectionView.reloadData()
            }).disposed(by: disposeBag)
    }
}

