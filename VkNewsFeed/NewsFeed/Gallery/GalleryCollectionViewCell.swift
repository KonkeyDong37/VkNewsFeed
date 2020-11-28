//
//  GalleryCollectionViewCell.swift
//  VkNewsFeed
//
//  Created by Андрей on 24.11.2020.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCollectionViewCell"
    
    let photoImageView: WebImageView = {
        let imageView = WebImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.8980392157, blue: 0.9098039216, alpha: 1)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        
        // Photo Image View Constarints
        photoImageView.fillSuperview()
    }
    
    override func prepareForReuse() {
        photoImageView.image = nil
    }
    
    func set(imageUrl: String?) {
        photoImageView.set(imageUrl: imageUrl)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = 3
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
