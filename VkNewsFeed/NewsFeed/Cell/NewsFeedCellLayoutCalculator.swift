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
    var moreTextButtonFrame: CGRect
}

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    private let screenWidth: CGFloat
    
    init(screenWidth: CGFloat = UIScreen.main.bounds.width) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSized: Bool) -> FeedCellSizes {
        
        var showMoreTextButton = false
        
        let cardViewWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        // MARK: Work with Post Label Frame
        
        var postLabelFrame = CGRect(
            origin: CGPoint(x: Constants.postLabelInsets.left, y: Constants.postLabelInsets.top),
            size: CGSize.zero)
        
        if let text = postText, !text.isEmpty {
            let width = cardViewWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(width: width, font: Constants.postLabelFont)
            let limitHeight = Constants.postLabelFont.lineHeight * Constants.minifiedPostLimitLines
            
            if !isFullSized && height > limitHeight {
                height = Constants.postLabelFont.lineHeight * Constants.minifiedPostLines
                showMoreTextButton = true
            }
            
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        // MARK: Work with More Text Button
        
        var moreTextButtonSize = CGSize.zero
        
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY + Constants.postLabelInsets.bottom)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        // MARK: Work with Photo Attachment
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ?
            Constants.postLabelInsets.top :
            moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        
        if let attacment = photoAttachments.first {
            let photoWidth: Float = Float(attacment.width)
            let photoHeight: Float = Float(attacment.height)
            let ratio: CGFloat = CGFloat(photoHeight / photoWidth)
            
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ratio)
            } else if photoAttachments.count > 1 {
                var photos = [CGSize]()
                for photo in photoAttachments {
                    let photoSize = CGSize(width: CGFloat(photo.width), height: CGFloat(photo.height))
                    photos.append(photoSize)
                }
                
                let rowHeight = RowLayout.rowHeightCounter(superviewWidth: cardViewWidth, photosArray: photos)
                attachmentFrame.size = CGSize(width: cardViewWidth, height: rowHeight!)
            }
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
            totalHeight: totalHeight,
            moreTextButtonFrame: moreTextButtonFrame)
    }
}
