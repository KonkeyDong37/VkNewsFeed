//
//  Constants.swift
//  VkNewsFeed
//
//  Created by Андрей on 17.11.2020.
//

import UIKit

struct Constants {
    static let mainTextColor: UIColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let secondaryTextColor: UIColor = #colorLiteral(red: 0.6, green: 0.6352941176, blue: 0.6784313725, alpha: 1)
    static let mainImageBackgroundColor: UIColor = #colorLiteral(red: 0.9332413673, green: 0.9333977103, blue: 0.9332208037, alpha: 1)
    
    static let cardInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
    
    static let headerHeight: CGFloat = 50
    static let headerInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    
    static let nameLabelFont = UIFont.systemFont(ofSize: 16, weight: .medium)
    static let nameLabelInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 0)
    
    static let dateLabelFont = UIFont.systemFont(ofSize: 13)
    static let dateLabelInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 0)
    
    static let postLabelInsets = UIEdgeInsets(top: 8 + Constants.headerHeight + 8, left: 8, bottom: 8, right: 8)
    static let postLabelFont = UIFont.systemFont(ofSize: 15)
    
    static let moreTextButtonSize = CGSize(width: 170, height: 30)
    static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    
    static let footerViewHeight: CGFloat = 52
    
    static let contentBoxInFooterViewSize: CGSize = CGSize(width: 79, height: footerViewHeight)
    
    static let contentBoxLabelFont: UIFont = UIFont.systemFont(ofSize: 14, weight: .medium)
    
    static let contentBoxIconSize = CGSize(width: 24, height: 24)
    static let contentBoxIconInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
    
    static let contentBoxLabelInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
    
    static let minifiedPostLimitLines: CGFloat = 8
    static let minifiedPostLines: CGFloat = 6
}
