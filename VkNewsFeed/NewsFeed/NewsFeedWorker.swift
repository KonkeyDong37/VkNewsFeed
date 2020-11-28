//
//  NewsFeedWorker.swift
//  VkNewsFeed
//
//  Created by Андрей on 09.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class NewsFeedService {
    
    var authService: AuthService
    var networking: Networking
    var fether: DataFetcher
    
    private var revealdedPostIds = [Int]()
    private var feedResponse: FeedResponse?
    private var newFromInProcess: String?
    
    init() {
        self.authService = SceneDelegate.shared().authService
        self.networking = NetworkService(authService: authService)
        self.fether = NetworkDataFetcher(networking: networking )
    }
    
    func getUser(completion: @escaping (UserResponse?) -> Void) {
        fether.getUser { (response) in
            completion(response )
        }
    }
    
    func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
        fether.getFeed(nextBatchFrom: nil) { [weak self] (response) in
            self?.feedResponse = response
            guard let response = self?.feedResponse else { return }
            completion(self!.revealdedPostIds, response)
        }
    }
    
    func revealPostId(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
        revealdedPostIds.append(postId)
        guard let response = self.feedResponse else { return }
        completion(revealdedPostIds, response)
    }
    
    func getNextBatch(completion: @escaping ([Int], FeedResponse) -> Void) {
        newFromInProcess = feedResponse?.nextFrom
        
        fether.getFeed(nextBatchFrom: newFromInProcess) { [weak self] (response) in
            guard let response = response else { return }
            guard self?.feedResponse?.nextFrom != response.nextFrom else { return }
            
            if self?.feedResponse == nil {
                self?.feedResponse = response
            } else {
                self?.feedResponse?.items.append(contentsOf: response.items)
                self?.feedResponse?.nextFrom = response.nextFrom
                
                var profiles = response.profiles
                if let oldProfiles = self?.feedResponse?.profiles {
                    let oldProfilesFiltered = oldProfiles.filter { (oldProfile) -> Bool in
                        !response.profiles.contains(where: { $0.id == oldProfile.id })
                    }
                    profiles.append(contentsOf: oldProfilesFiltered )
                }
                self?.feedResponse?.profiles = profiles
                
                var groups = response.groups
                if let oldGroups = self?.feedResponse?.groups {
                    let oldGroupsFiltered = oldGroups.filter { (oldGroup) -> Bool in
                        !response.groups.contains(where: { $0.id == oldGroup.id })
                    }
                    groups.append(contentsOf: oldGroupsFiltered)
                }
                self?.feedResponse?.groups = groups
            }
            
            guard let feedResponse = self?.feedResponse else { return }
            completion(self!.revealdedPostIds, feedResponse)
        }
    }
}
