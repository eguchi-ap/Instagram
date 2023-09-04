//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by WEBSYSTEM-MAC39 on 2023/09/01.
//

import UIKit
import FirebaseStorageUI

class PostTableViewCell: UITableViewCell {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    func setPostData(_ postData: PostData) {
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        let imageRef = Storage.storage().reference().child(Const.PostPath).child(postData.id + ".jpg")
        postImageView.sd_setImage(with: imageRef)
        
        self.captionLabel.text = "\(postData.name) : \(postData.caption)"
        self.dateLabel.text = postData.date
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"
        
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
