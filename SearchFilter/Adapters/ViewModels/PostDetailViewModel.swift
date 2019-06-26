//
//  PostDetailViewModel.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 20/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import RxSwift

class PostDetailViewModel {
    
    var postViewParam = PostViewParam()
    
    private let eventLoadPostInfo = PublishSubject<PostViewParam>()
    
    var rxEventLoadPostInfo: Observable<PostViewParam> {
        return eventLoadPostInfo
    }
    
    func viewLoad() {
        eventLoadPostInfo.onNext(postViewParam)
    }
    
}
