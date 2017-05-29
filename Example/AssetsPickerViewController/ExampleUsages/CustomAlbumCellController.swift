//
//  CustomAlbumCellController.swift
//  AssetsPickerViewController
//
//  Created by DragonCherry on 5/29/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Photos
import AssetsPickerViewController
import TinyLog
import PureLayout

private let imageSize = CGSize(width: 80, height: 80)

class CustomAlbumCell: UICollectionViewCell, AssetsAlbumCellProtocol {
    
    // MARK: - AssetsAlbumCellProtocol
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView.layer.borderWidth = 3
                imageView.layer.borderColor = UIColor.red.cgColor
            } else {
                imageView.layer.borderWidth = 0
            }
        }
    }
    
    var imageView: UIImageView = {
        let view = UIImageView.newAutoLayout()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        view.backgroundColor = UIColor(rgbHex: 0xF0F0F0)
        return view
    }()
    
    var titleText: String? {
        didSet {
            if let titleText = self.titleText {
                titleLabel.text = "\(titleText) (\(count))"
            } else {
                titleLabel.text = nil
            }
        }
    }
    
    var count: Int = 0 {
        didSet {
            if let titleText = self.titleText {
                titleLabel.text = "\(titleText) (\(count))"
            } else {
                titleLabel.text = nil
            }
        }
    }
    
    // MARK: - At your service
    private var didSetupConstraints: Bool = false
    
    var titleLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.clipsToBounds = true
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            imageView.autoSetDimensions(to: imageSize)
            imageView.autoPinEdge(.leading, to: .leading, of: contentView)
            titleLabel.autoPinEdge(.leading, to: .trailing, of: imageView)
            titleLabel.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .leading)
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
}

class CustomAlbumCellController: CommonExampleController {
    
    override func pressedPick(_ sender: Any) {
        
        let pickerConfig = AssetsPickerConfig()
        pickerConfig.albumCellType = CustomAlbumCell.classForCoder()
        pickerConfig.albumForcedCellHeight = imageSize.height
        pickerConfig.albumForcedCacheSize = imageSize
        pickerConfig.albumDefaultSpace = 0
        pickerConfig.albumPortraitColumnCount = 1
        pickerConfig.albumLandscapeColumnCount = 1
        
        let picker = AssetsPickerViewController(pickerConfig: pickerConfig)
        picker.pickerDelegate = self
        
        present(picker, animated: true, completion: nil)
    }
}
