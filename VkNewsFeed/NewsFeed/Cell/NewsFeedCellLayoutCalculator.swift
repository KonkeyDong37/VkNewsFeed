//
//  NewsFeedCellLayoutCalculator.swift
//  VkNewsFeed
//
//  Created by Андрей on 16.11.2020.
//

import UIKit

struct Sizes: FeedCellSizes {
    var postLabelFrame: CGRect
    var attachmentFrame: CGRect
    var footerViewFrame: CGRect
    var totalHeight: CGFloat
}

struct Constants {
    static let cardInsets = UIEdgeInsets(
        top: 5,
        left: 10,
        bottom: 5,
        right: 10)
    static let headerHeight: CGFloat = 50
    static let postLabelInsets = UIEdgeInsets(
        top: 8 + Constants.headerHeight + 8,
        left: 8,
        bottom: 8,
        right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    static let footerViewHeight: CGFloat = 52
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Work with Post Label Frame
        
        var postLabelFrame = CGRect(
            origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
            size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(width: width, font: Constants.postLabelFont)
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Work with Photo Attachment
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ?
            Constants.postLabelInsets.top :
            postLabelFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attacment = photoAttachment {
            let photoWidth: Float = Float(attacment.width)
            let photoHeight: Float = Float(attacment.height)
            let ration: CGFloat = CGFloat(photoHeight / photoWidth)
            
            attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ration)
        }
        
        // MARK: Work with Footer View Frame
        
        let footerViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
        let footerViewFrame = CGRect(
            origin: CGPoint(x: 0, y: footerViewTop),
            size: CGSize(width: cardViewWidth, height: Constants.footerViewHeight)
        )
        
        // MARK: Work with Totl Height
        
        let totalHeight = footerViewFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(
            postLabelFrame: postLabelFrame,
            attachmentFrame: attachmentFrame,
            footerViewFrame: footerViewFrame,
            totalHeight: totalHeight)
    }
}
