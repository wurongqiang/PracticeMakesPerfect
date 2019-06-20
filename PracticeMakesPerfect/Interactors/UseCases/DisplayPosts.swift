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
        let postsFromCache = getAllPostsFromCache()
        let postsFromServer = getAllPostsFromServer()
        
        return Observable.of(postsFromCache, postsFromServer).merge()
    }
    
    private func getAllPostsFromCache() -> Observable<[PostViewParam]> {
        let posts = postsStorage.getPosts()
        guard !posts.isEmpty else {
            return Observable.empty()
        }
        let postViewParams = PostViewParam.create(posts: posts)
        
        return .just(postViewParams)
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
