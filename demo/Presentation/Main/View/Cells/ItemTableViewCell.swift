//
//  ItemTableViewCell.swift
//  demo
//
//  Created by Sky on 12/09/2021.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var serviceImage: UIImageView!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var personalLabel: UILabel!
    @IBOutlet weak var personalImage: UIImageView!
    @IBOutlet weak var accidentLabel: UILabel!
    @IBOutlet weak var accidentImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var belowLabel: UILabel!
    @IBOutlet weak var badgeLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    static let reuseIdentifier = String(describing: ItemTableViewCell.self)
    var phoneNumber: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Icon
        serviceImage.image = #imageLiteral(resourceName: "service")
        ownerImage.image = #imageLiteral(resourceName: "teamwork")
        personalImage.image = #imageLiteral(resourceName: "house")
        accidentImage.image = #imageLiteral(resourceName: "checked")
        itemImageView.image = #imageLiteral(resourceName: "placeholder")
        
        // Label
        statusLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        statusLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        subTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        badgeLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        badgeLabel.textColor = .white
        belowLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        belowLabel.textColor = .systemGreen
        valueLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        accidentLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        personalLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        ownerLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        serviceLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        itemImageView.image = #imageLiteral(resourceName: "placeholder")
    }
    
    func config(with car: Car) {
        phoneNumber = car.dealerPhone
        phoneButton.setTitle(car.dealerPhone, for: .normal)
        serviceLabel.text = car.serviceHistoryText
        ownerLabel.text = car.ownerNumberText
        personalLabel.text = "\(car.personalUse ? "" : "Not ")Personal Use"
        accidentLabel.text = car.accidentStatus
        valueLabel.text = "CARFAX Value"
        belowLabel.text = "$50 Below"
        badgeLabel.text = car.badge
        subTitleLabel.text = car.subTitle
        titleLabel.text = car.title
        statusLabel.text = car.status
        statusView.isHidden = car.status == nil
        if let url = URL(string: car.photo) {
            itemImageView.load(url: url)
        }
    }
    
    @IBAction func phoneButtonTapped(_ sender: Any) {
        if let url = URL(string: "tel://\(phoneNumber)"),
           UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}
