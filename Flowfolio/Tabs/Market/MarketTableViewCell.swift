//
//  MarketTableViewCell.swift
//  Flowfolio
//
//  Created by Yasir on 26/02/23.
//

import Foundation
import UIKit

class MarketTableViewCell: UITableViewCell {
    
    var editionData: EditionData? {
        didSet {
            configureViewComponents()
        }
    }
    var seriesData: SeriesData?
    var playData: PlayData? {
        didSet {
            configureViewComponents()
        }
    }
    var playDataId: [String:String]? {
        didSet {
            if let url = getPlayDataImageUrl() {
                playDataImageView.load(url)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
        configureViewComponents()
        configureViewLayout()
    }
    
    func configureView() {
        contentView.addSubview(cardView)
        cardView.addSubview(playDataImageView)
        
        cardView.addSubview(playerName)
        cardView.addSubview(secondaryStack)
        cardView.addSubview(descLabel)
        
        secondaryStack.addArrangedSubview(tier)
        secondaryStack.addArrangedSubview(editionSize)
    }
    
    func configureViewComponents() {
        
        contentView.backgroundColor = .black
        cardView.layer.borderWidth = 1.0
        cardView.getBorderAnimation(from: UIColor.black.cgColor, to: getBackgroundColor().cgColor)
        
        playerName.textColor = .white
        playerName.text = getPlayerName()
        
        tier.textColor = getBackgroundColor()
        tier.text = getTier()
        
        editionSize.textColor = .lightGray
        editionSize.text = getEditionSize()
        
        descLabel.textColor = .lightGray
        descLabel.text = getDescText()
    }
    
    func configureViewLayout() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        playDataImageView.translatesAutoresizingMaskIntoConstraints = false
        playDataImageView.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        playDataImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor).isActive = true
        playDataImageView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.75).isActive = true
        playDataImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor).isActive = true
        
        
        secondaryStack.translatesAutoresizingMaskIntoConstraints = false
        secondaryStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor).isActive = true
        secondaryStack.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        playerName.translatesAutoresizingMaskIntoConstraints = false
        playerName.bottomAnchor.constraint(equalTo: secondaryStack.topAnchor, constant: -8).isActive = true
        playerName.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.topAnchor.constraint(equalTo: secondaryStack.bottomAnchor, constant: 8).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .black
        cardView.layer.cornerRadius = 8.0
        cardView.layer.masksToBounds = false
        cardView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.2)
        cardView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardView.layer.shadowOpacity = 0.8
        return cardView
    }()
    
    let playDataImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        return imageView
    }()
    
    let playerName: UILabel = {
        let playerName = UILabel()
        playerName.font = .systemFont(ofSize: 18, weight: .medium)
        return playerName
    }()
    
    let secondaryStack: UIStackView = {
        let secondaryStack = UIStackView()
        secondaryStack.axis = .horizontal
        secondaryStack.spacing = 4.0
        return secondaryStack
    }()
    
    let tier: UILabel = {
        let tier = UILabel()
        tier.font = .systemFont(ofSize: 15, weight: .regular)
        return tier
    }()
    
    let editionSize: UILabel = {
        let editionSize = UILabel()
        editionSize.font = .systemFont(ofSize: 15, weight: .regular)
        return editionSize
    }()
    
    let descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.font = .systemFont(ofSize: 15, weight: .regular)
        return descLabel
    }()
    
    func getBackgroundColor() -> UIColor {
        guard let editionData else {
            return .black
        }
        switch editionData.tier {
        case EditionTier.COMMON.rawValue:
            return .darkGray
        case EditionTier.RARE.rawValue:
            return #colorLiteral(red: 0.9821659923, green: 0.5637723207, blue: 0.5483688712, alpha: 1)
        case EditionTier.LEGENDARY.rawValue:
            return #colorLiteral(red: 0.7721281648, green: 0.5016978383, blue: 0.9641402364, alpha: 1)
        case EditionTier.UNCOMMON.rawValue:
            return .lightGray
        default:
            return.black
        }
    }
    
    func getPlayDataImageUrl() -> String? {
        
        if let playDataId = playDataId, let pDI = playDataId[PlayMetaData.PlayDataID.rawValue]  {
            let mediaType = "capture_Hero_Black"
            let baseURL = "https://laligagolazos.com/cdn-cgi/image/width=800,height=800,quality=100/https://storage.googleapis.com/dl-laliga-assets-prod/editions/"
            let imgURL =  "\(pDI)/play_\(pDI)__\(mediaType)_2880_2880_default.png"
            return baseURL+imgURL
        }
        return nil
    }
    
    func getPlayerName() -> String {
        var result: String = ""
        //        if let editionData = editionData {
        //            result += "\(editionData.id). "
        //        }
        if let playData = playData {
            var playerName = playData.metadata[PlayMetaData.PlayerKnownName.rawValue]!
            if playerName.count == 0 {
                playerName = playData.metadata[PlayMetaData.PlayerFirstName.rawValue]! + " " + playData.metadata[PlayMetaData.PlayerLastName.rawValue]!
            }
            result += "\(playerName)"
        }
        return result
    }
    
    func getTier() -> String {
        var result: String = ""
        if let editionData = editionData {
            result += "\(editionData.tier.capitalized)"
        }
        return result
    }
    
    func getEditionSize() -> String {
        var result: String = "#/"
        if let editionData = editionData, let editionSize = editionData.maxMintSize {
            result += "\(editionSize)"
        }
        return result.count == 2 ? "" : result
    }
    
    func getDescText() -> String {
        var result: String = ""
        if let playData = playData {
            result += "\(playData.metadata[PlayMetaData.PlayType.rawValue]!.capitalized), \(playData.metadata[PlayMetaData.MatchHomeTeam.rawValue]!)"
        }
        return result
    }
}

extension UIView {
    func getBorderAnimation(from: CGColor, to: CGColor) {
        let borderColorAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderColor")
        borderColorAnimation.fromValue = from
        borderColorAnimation.toValue = to
        layer.add(borderColorAnimation, forKey: "borderColor")
        layer.borderColor = to
    }
}

extension UIImageView {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        self?.contentMode = .scaleAspectFill
                    }
                }
            }
        }
    }
}