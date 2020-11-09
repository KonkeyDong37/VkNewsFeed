//
//  FeedViewController.swift
//  VkNewsFeed
//
//  Created by Андрей on 08.11.2020.
//

import UIKit

class FeedViewController: UIViewController {
    
    private let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkService.getFeed()
        view.backgroundColor = .systemTeal
    }
}
