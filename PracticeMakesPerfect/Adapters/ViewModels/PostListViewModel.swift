//
//  ListViewModel.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

class PostListViewModel {
    
    private let displayPosts: DisplayPosts
    private let disposeBag = DisposeBag()
    private (set) var postViewParams = [PostViewParam]()
    
    private let eventPostsLoaded = PublishSubject<Void>()
    
    var rxEventPostsLoaded: Observable<Void> {
        return eventPostsLoaded
    }
    
    init(displayPosts: DisplayPosts) {
        self.displayPosts = displayPosts
    }
    
    func viewLoad() {
        loadPosts()
    }
    
    private func loadPosts() {
        displayPosts.getPosts().subscribe(onNext: { [weak self] posts in
            guard let weakSelf = self else { return }
            weakSelf.postViewParams = posts
            weakSelf.eventPostsLoaded.onNext(())
        }).disposed(by: disposeBag)
    }
}
