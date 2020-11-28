//
//  NewsFeedCodeCell.swift
//  VkNewsFeed
//
//  Created by Андрей on 17.11.2020.
//

import UIKit

protocol NewsFeedCodeCellDelegate: class {
    func revealPost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
    
    static let reuseId = "NewsFeedCodeCell"
    
    weak var delegate: NewsFeedCodeCellDelegate?
    
    // Main layer
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // Second layer
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postLabel: UITextView = {
        let textView = UITextView()
        textView.font = Constants.postLabelFont
        textView.isScrollEnabled = false
        textView.isSelectable = true
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
        textView.dataDetectorTypes = .all
        textView.backgroundColor = .white
        textView.textColor = .black
        
        let padding = textView.textContainer.lineFragmentPadding
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -padding, bottom: 0, right: -padding)
        return textView
    }()
    
    let moreTextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        button.setTitleColor(#colorLiteral(red: 0.4, green: 0.6235294118, blue: 0.831372549, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .left
        button.contentVerticalAlignment = .center
        button.setTitle("Показать полностью...", for: .normal)
        return button
    }()
    
    let postImageView: WebImageView = {
        let image = WebImageView()
        image.backgroundColor = Constants.mainImageBackgroundColor
        return image
    }()
    
    let galleryCollectionView = GalleryCollectionView()
    
    let footerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // Third layer on the Header View
    
    let iconImageView: WebImageView = {
        let image = WebImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = Constants.mainImageBackgroundColor
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.nameLabelFont
        label.textColor = Constants.mainTextColor
        label.numberOfLines = 0
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.dateLabelFont
        label.textColor = Constants.secondaryTextColor
        label.numberOfLines = 0
        return label
    }()
    
    // Third layer on the Footer View
    
    let likesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let commentsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sharesView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Fourth layer on the Footer View
    
    let likesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "like")
        return image
    }()
    
    let commentsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "comment")
        return image
    }()
    
    let sharesImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "share")
        return image
    }()
    
    let viewsImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "eye")
        return image
    }()
    
    let likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.contentBoxLabelFont
        label.textColor = Constants.secondaryTextColor
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.contentBoxLabelFont
        label.textColor = Constants.secondaryTextColor
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let sharesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.contentBoxLabelFont
        label.textColor = Constants.secondaryTextColor
        label.lineBreakMode = .byClipping
        return label
    }()
    
    let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.contentBoxLabelFont
        label.textColor = Constants.secondaryTextColor
        label.lineBreakMode = .byClipping
        return label
    }()
    
    override func prepareForReuse() {
        iconImageView.set(imageUrl: nil)
        postImageView.set(imageUrl: nil)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconImageView.layer.cornerRadius = Constants.headerHeight / 2
        iconImageView.clipsToBounds = true
        
        backgroundColor = .clear
        selectionStyle = .none
        
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = false
        
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 0.3
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 2
        
        moreTextButton.addTarget(self, action: #selector(showFullPostText), for: .touchUpInside)
        
        overlayFirstLayer()
        overlaySecondLayer()
        overlayThirdLayerOnHeaderView()
        overlayThirdLayerOnFooterView()
        overlaysFourthLayerOnFooterLayer()
    }
    
    @objc func showFullPostText() {
        delegate?.revealPost(for: self)
    }
    
    func set(viewModel: NewsFeedCellViewModel) {
        
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        postLabel.frame = viewModel.sizes.postLabelFrame
        footerView.frame = viewModel.sizes.footerViewFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        if let photo = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            postImageView.set(imageUrl: photo.url)
            postImageView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = false
            galleryCollectionView.isHidden = true
        } else if viewModel.photoAttachments.count > 1 {
            galleryCollectionView.set(photos: viewModel.photoAttachments)
            galleryCollectionView.frame = viewModel.sizes.attachmentFrame
            postImageView.isHidden = true
            galleryCollectionView.isHidden = false
        }
        else {
            postImageView.isHidden = true
            galleryCollectionView.isHidden = true
        }
    }
    
    private func overlaysFourthLayerOnFooterLayer() {
        likesView.addSubview(likesImage)
        likesView.addSubview(likesLabel)
        
        commentsView.addSubview(commentsImage)
        commentsView.addSubview(commentsLabel)

        sharesView.addSubview(sharesImage)
        sharesView.addSubview(sharesLabel)

        viewsView.addSubview(viewsImage)
        viewsView.addSubview(viewsLabel)

        helpInFourthLayer(view: likesView, image: likesImage, label: likesLabel)
        helpInFourthLayer(view: commentsView, image: commentsImage, label: commentsLabel)
        helpInFourthLayer(view: sharesView, image: sharesImage, label: sharesLabel)
        helpInFourthLayer(view: viewsView, image: viewsImage, label: viewsLabel)
    }
    
    private func helpInFourthLayer(view: UIView, image: UIImageView, label: UILabel) {
        
        image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -2).isActive = true
        image.anchor(
            top: nil,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: nil,
            padding: Constants.contentBoxIconInsets,
            size: Constants.contentBoxIconSize)
        
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -2).isActive = true
        label.anchor(
            top: nil,
            leading: image.trailingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: Constants.contentBoxLabelInsets)
    }
    
    private func overlayThirdLayerOnFooterView() {
        footerView.addSubview(likesView)
        footerView.addSubview(commentsView)
        footerView.addSubview(sharesView)
        footerView.addSubview(viewsView)
        
        // Likes View constants
        likesView.anchor(
            top: footerView.topAnchor,
            leading: footerView.leadingAnchor,
            bottom: footerView.bottomAnchor,
            trailing: nil,
            size: Constants.contentBoxInFooterViewSize)
        
        commentsView.anchor(
            top: footerView.topAnchor,
            leading: likesView.trailingAnchor,
            bottom: footerView.bottomAnchor,
            trailing: nil,
            size: Constants.contentBoxInFooterViewSize)
        
        sharesView.anchor(
            top: footerView.topAnchor,
            leading: commentsView.trailingAnchor,
            bottom: footerView.bottomAnchor,
            trailing: nil,
            size: Constants.contentBoxInFooterViewSize)
        
        viewsView.anchor(
            top: footerView.topAnchor,
            leading: nil,
            bottom: footerView.bottomAnchor,
            trailing: footerView.trailingAnchor,
            size: Constants.contentBoxInFooterViewSize)
    }
    
    private func overlayThirdLayerOnHeaderView() {
        headerView.addSubview(iconImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(dateLabel)
        
        
        // Icon Image View constants
        iconImageView.anchor(
            top: headerView.topAnchor,
            leading: headerView.leadingAnchor,
            bottom: nil,
            trailing: nil,
            size: CGSize(width: Constants.headerHeight, height: Constants.headerHeight))
        
        // Name Label constants
        nameLabel.anchor(
            top: headerView.topAnchor,
            leading: iconImageView.trailingAnchor,
            bottom: nil,
            trailing: headerView.trailingAnchor,
            padding: Constants.nameLabelInsets,
            size: CGSize(width: 0, height: Constants.headerHeight / 2 - 2))
        
        // Date Label constants
        dateLabel.anchor(
            top: nil,
            leading: iconImageView.trailingAnchor,
            bottom: headerView.bottomAnchor,
            trailing: headerView.trailingAnchor,
            padding: Constants.dateLabelInsets,
            size: CGSize(width: 0, height:  Constants.headerHeight / 2 - 6))
    }
    
    private func overlaySecondLayer() {
        cardView.addSubview(headerView)
        cardView.addSubview(postLabel)
        cardView.addSubview(moreTextButton)
        cardView.addSubview(postImageView)
        cardView.addSubview(galleryCollectionView)
        cardView.addSubview(footerView)
        
        // Header View constants
        headerView.anchor(
            top: cardView.topAnchor,
            leading: cardView.leadingAnchor,
            bottom: nil,
            trailing: cardView.trailingAnchor,
            padding: Constants.headerInsets)
        headerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight).isActive = true
    }
    
    private func overlayFirstLayer() {
        addSubview(cardView)
        cardView.fillSuperview(padding: Constants.cardInsets)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
