//
//  NewsFeedInteractor.swift
//  VkNewsFeed
//
//  Created by Андрей on 09.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
    func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {
    
    var presenter: NewsFeedPresentationLogic?
    var service: NewsFeedService?
    
    func makeRequest(request: NewsFeed.Model.Request.RequestType) {
        if service == nil {
            service = NewsFeedService()
        }
        
        switch request {
        case .getNewsFeed:
            service?.getFeed(completion: { [weak self] (revealPostId, response) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: response, revealdedPostIds: revealPostId))
            })
        case .getUser:
            service?.getUser(completion: { [weak self] (response) in
                self?.presenter?.presentData(response: .presentUserInfo(user: response))
            })
        case .revealPostId(postId: let postId):
            service?.revealPostId(forPostId: postId, completion: { [weak self] (revealPostId, response) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: response, revealdedPostIds: revealPostId ))
            })
        case .getNextBatch:
            service?.getNextBatch(completion: { [weak self] (revealPostIds, response ) in
                self?.presenter?.presentData(response: .presentNewsFeed(feed: response, revealdedPostIds: revealPostIds))
            })
            presenter?.presentData(response: .presentFooterLoader)
        }
    }
}
