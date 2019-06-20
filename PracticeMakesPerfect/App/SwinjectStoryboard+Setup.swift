//
//  SwinjectStoryboard+Setup.swift
//  PracticeMakesPerfect
//
//  Created by Jimmy Wu on 19/06/19.
//  Copyright © 2019 jimmy. All rights reserved.
//

import Foundation
import SwinjectStoryboard

extension SwinjectStoryboard {
    
    class func setup() {
        registerStoryboards()
        
        registerViewModels()
        
        registerInteractors()
        
        registerApis()
        
        registerStorages()
    }
    
    class func resolveDefault<Service>(_ service: Service.Type) -> Service? {
        return SwinjectStoryboard.defaultContainer.resolve(service)
    }
    
    private class func registerStoryboards() {
        defaultContainer.storyboardInitCompleted(PostListViewController.self) { r, c in
            c.postListViewModel = r.resolve(PostListViewModel.self)!
        }
    }
    
    private class func registerViewModels() {
        defaultContainer.register(PostListViewModel.self) { r in
            PostListViewModel(displayPosts: r.resolve(DisplayPosts.self)!)
        }
    }
    
    private class func registerInteractors() {
        defaultContainer.register(DisplayPosts.self) { r in
            DisplayPostsImpl(postApi: r.resolve(PostApi.self)!, postStorage: r.resolve(PostsStorage.self)!)
        }
    }
    
    private class func registerApis() {
        defaultContainer.register(PracticeMakesPerfectApiClient.self) { r in
            PracticeMakesPerfectApiClientImpl()
        }
        
        defaultContainer.register(PostApi.self) { r in
            PostApiImpl(practiceMakesPerfectApiClient: r.resolve(PracticeMakesPerfectApiClient.self)!)
        }
    }
    
    private class func registerStorages() {
        defaultContainer.register(PostsStorage.self) { r in
            PostsRealmStorage()
        }
    }
    
}
