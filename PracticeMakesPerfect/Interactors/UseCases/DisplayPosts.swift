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
    
    func getPosts() -> Observable<[PostViewParam]> {
        var posts = [PostViewParam]()
        
        
        posts.append(PostViewParam.init(id: 0, userId: 0, title: "Priscilla Candra", body: "Seorang yang sangat menyebalkan", image: URL(string: "https://instagram.fcgk7-1.fna.fbcdn.net/vp/5302f0076498f732a15434de139df574/5DC70068/t51.2885-19/s150x150/15801886_1562521650427820_7007391726432157696_a.jpg?_nc_ht=instagram.fcgk7-1.fna.fbcdn.net&_nc_cat=108")!));   posts.append(PostViewParam.init(id: 1, userId: 101, title: "Title 1", body: "Body 1", image: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Big_%26_Small_Pumkins.JPG/800px-Big_%26_Small_Pumkins.JPG")!))
        posts.append(PostViewParam.init(id: 2, userId: 102, title: "Title 2", body: "Body 2", image: URL(string: "https://images-na.ssl-images-amazon.com/images/I/71psZ8E0AOL._SL1500_.jpg")!))
        posts.append(PostViewParam.init(id: 3, userId: 103, title: "Title 3", body: "Body 3", image: URL(string: "https://hellosehat.com/wp-content/uploads/2018/03/Mewaspadai-Infeksi-Listeria-pada-Rock-Melon-Australia-Ini-Bahayanya.jpg")!))
        
        return .just(posts)
    }
    
}
