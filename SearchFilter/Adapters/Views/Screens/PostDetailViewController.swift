//
//  PostDetailViewController.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import UIKit
import RxSwift

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var postDetailViewModel: PostDetailViewModel!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        setupPostDetailViewModel()
        
        postDetailViewModel.viewLoad()
    }
    
    // MARK: - Private
    
    private func setupPostDetailViewModel() {
        postDetailViewModel.rxEventLoadPostInfo.subscribe(onNext: { [weak self] postViewParam in
            guard let weakSelf = self else { return }
            weakSelf.titleLabel.text = postViewParam.title
            weakSelf.bodyLabel.text = postViewParam.body
        }).disposed(by: disposeBag)
    }
    
}

