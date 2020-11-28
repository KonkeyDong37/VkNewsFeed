//
//  TitleView.swift
//  VkNewsFeed
//
//  Created by Андрей on 27.11.2020.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

class TitleView: UIView {
    
    private var searchField = InsetableTextField()
    
    private var avatarView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .blue
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(searchField)
        addSubview(avatarView)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setConstraints()
    }
    
    func set(userViewModel: TitleViewViewModel) {
        avatarView.set(imageUrl: userViewModel.photoUrlString)
    }

    private func setConstraints() {
        searchField.anchor(top: topAnchor,
                           leading: leadingAnchor,
                           bottom: bottomAnchor,
                           trailing: avatarView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 8))
        
        avatarView.anchor(top: topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: trailingAnchor,
                          padding: UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 4))
        avatarView.heightAnchor.constraint(equalTo: searchField.heightAnchor, multiplier: 1).isActive = true
        avatarView.widthAnchor.constraint(equalTo: searchField.heightAnchor, multiplier: 1).isActive = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarView.layer.cornerRadius = avatarView.layer.frame.width / 2
        avatarView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
