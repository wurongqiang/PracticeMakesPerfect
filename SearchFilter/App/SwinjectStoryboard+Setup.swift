//
//  SwinjectStoryboard+Setup.swift
//  SearchFilter
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
        defaultContainer.storyboardInitCompleted(ProductListViewController.self) { r, c in
            c.productListViewModel = r.resolve(ProductListViewModel.self)!
        }
    }
    
    private class func registerViewModels() {
        defaultContainer.register(ProductListViewModel.self) { r in
            ProductListViewModel(displayProducts: r.resolve(DisplayProducts.self)!)
        }
    }
    
    private class func registerInteractors() {
        defaultContainer.register(DisplayProducts.self) { r in
            DisplayProductsImpl(productApi: r.resolve(ProductApi.self)!, productStorage: r.resolve(ProductsStorage.self)!)
        }
    }
    
    private class func registerApis() {
        defaultContainer.register(SearchFilterApiClient.self) { r in
            SearchFilterApiClientImpl()
        }
        
        defaultContainer.register(ProductApi.self) { r in
            ProductApiImpl(practiceMakesPerfectApiClient: r.resolve(SearchFilterApiClient.self)!)
        }
    }
    
    private class func registerStorages() {
        defaultContainer.register(ProductsStorage.self) { r in
            ProductsRealmStorage()
        }
    }
    
}
