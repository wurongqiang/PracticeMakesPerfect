//
//  DisplayPosts.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

protocol DisplayPosts {
    func getPosts() -> Observable<[PostViewParam]>
}

class DisplayPostsImpl: DisplayPosts {
    
    private let postApi: PostApi
    private let postsStorage: PostsStorage
    private let disposeBag = DisposeBag()
    
    init(postApi: PostApi, postStorage: PostsStorage) {
        self.postApi = postApi
        self.postsStorage = postStorage
    }
    
    func getPosts() -> Observable<[PostViewParam]> {
        guard postsStorage.getPosts().isEmpty else {
            defer {
                getAllPostsFromServer().subscribe(onNext: { _ in }).disposed(by: disposeBag)
            }
            return Observable.just(PostViewParam.create(posts: postsStorage.getPosts()))
        }
        return getAllPostsFromServer()
    }
    
    private func getAllPostsFromServer() -> Observable<[PostViewParam]> {
        return postApi.getAllPosts()
            .map { [weak self] posts in
                guard let weakSelf = self else { return [PostViewParam]() }
                weakSelf.postsStorage.save(posts: posts)
                return PostViewParam.create(posts: posts)
            }
    }
    
}
