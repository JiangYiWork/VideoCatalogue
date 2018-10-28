//
//  CatalogueTableViewCell.swift
//  VideoCatalogue
//
//  Created by Yi JIANG on 27/10/18.
//  Copyright © 2018 Siphty. All rights reserved.
//

import UIKit
import Kingfisher

class CatalogueTableViewCell: UITableViewCell {
    
    var catalogue: Catalogue?
    var delegate: CatalogueTableViewCellDelegate?
    
    var isFeatures: Bool{
        get {
            return catalogue?.category?.caseInsensitiveCompare("Features") == .orderedSame
        }
    }
    
    @IBOutlet weak var carouselView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carouselView.delegate = self
        carouselView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension CatalogueTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogue?.items?.count ?? 0
    }
    //cellForItemAt indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselCell", for: indexPath) as! CarouselCollectionViewCell
        if let item = catalogue?.items?[indexPath.row],
        let posterUrlString = isFeatures ? item.images?.landscape : item.images?.portrait
        {
            cell.itemTitleLabel.text = item.title ?? "No title"
            let posterUrl = URL(string: posterUrlString)
            cell.itemImageView.kf.setImage(with: posterUrl, placeholder: Image(named: "placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        return cell
    }
    
    
    //MARK:UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return isFeatures ? CGSize(width: 200, height: 143) : CGSize(width: 117, height: 205)
        
    }
    
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets{
    //        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    //    }
    
    //    header高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: 5, height: collectionView.frame.height)
    }
    //    //footer高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: 5, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let item = catalogue?.items?[indexPath.row] {
            delegate?.selectedAsset(item)
        }
    }
    
}

protocol CatalogueTableViewCellDelegate {
    func selectedAsset(_ item: Item)
}

