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
            if let url = getPlayDataImageUrl() {
                playDataImageView.load(url)
            }
            configureViewComponents()
        }
    }
    var playerData: PlayerData? {
        didSet {
            configureViewComponents()
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
        cardView.addSubview(priceStack)
        cardView.addSubview(marketCap)
        
        secondaryStack.addArrangedSubview(tier)
        secondaryStack.addArrangedSubview(editionSize)
        
        priceStack.addArrangedSubview(askLabel)
        priceStack.addArrangedSubview(priceLabel)
    }
    
    func configureViewComponents() {
        
        contentView.backgroundColor = .black
        cardView.layer.borderWidth = 1.0
        cardView.getBorderAnimation(from: UIColor.black.cgColor, to: getBackgroundColor().cgColor)
        cardView.layer.shadowColor = getBackgroundColor().cgColor.copy(alpha: 1)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.shadowRadius = 5.0
        
        playerName.textColor = .white
        playerName.text = getPlayerName()
        
        tier.textColor = getBackgroundColor()
        tier.text = getTier()
        
        editionSize.textColor = .lightGray
        editionSize.text = getEditionSize()
        
        descLabel.textColor = .lightGray
        descLabel.text = getDescText()
        
        askLabel.textColor = .white
        askLabel.text = "Lowest Ask:"
        
        priceLabel.textColor = .white
        priceLabel.text = getPrice()
        
        marketCap.textColor = .lightGray
        marketCap.text = getMarketCap()
    }
    
    func configureViewLayout() {
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
        
        playDataImageView.translatesAutoresizingMaskIntoConstraints = false
        playDataImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 4).isActive = true
        playDataImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 4).isActive = true
        playDataImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -4).isActive = true
        playDataImageView.trailingAnchor.constraint(equalTo: playDataImageView.leadingAnchor, constant: 132).isActive = true
        
        secondaryStack.translatesAutoresizingMaskIntoConstraints = false
        secondaryStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor, constant: -24).isActive = true
        secondaryStack.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        playerName.translatesAutoresizingMaskIntoConstraints = false
        playerName.bottomAnchor.constraint(equalTo: secondaryStack.topAnchor, constant: -8).isActive = true
        playerName.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.topAnchor.constraint(equalTo: secondaryStack.bottomAnchor, constant: 8).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        priceStack.translatesAutoresizingMaskIntoConstraints = false
        priceStack.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 8).isActive = true
        priceStack.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
        marketCap.translatesAutoresizingMaskIntoConstraints = false
        marketCap.topAnchor.constraint(equalTo: priceStack.bottomAnchor, constant: 8).isActive = true
        marketCap.leadingAnchor.constraint(equalTo: playDataImageView.trailingAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let cardView: UIView = {
        let cardView = UIView()
        cardView.backgroundColor = .black
        cardView.layer.cornerRadius = 8.0
        cardView.layer.masksToBounds = false
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
    
    let priceStack: UIStackView = {
        let priceStack = UIStackView()
        priceStack.axis = .horizontal
        priceStack.spacing = 4.0
        return priceStack
    }()
    
    let askLabel: UILabel = {
       let askLabel = UILabel()
        askLabel.font = .systemFont(ofSize: 15, weight: .thin)
        return askLabel
    }()
    
    let priceLabel: UILabel = {
        let priceLabel = UILabel()
        priceLabel.font = .systemFont(ofSize: 15, weight: .medium)
        return priceLabel
    }()
    
    let marketCap: UILabel = {
        let marketCap = UILabel()
        marketCap.font = .systemFont(ofSize: 15, weight: .regular)
        return marketCap
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
        
        if let playData = playData, let pDI = playData.metadata[PlayMetaData.PlayDataID.rawValue]  {
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
            if let playData = playData {
                result += ", \(playData.metadata[PlayMetaData.PlayType.rawValue]!.capitalized)"
            }
        }
        return result.count == 2 ? "" : result
    }
    
    func getDescText() -> String {
        var result: String = ""
        if let playData = playData {
            result += "\(playData.metadata[PlayMetaData.MatchHomeTeam.rawValue]!) Vs \(playData.metadata[PlayMetaData.MatchAwayTeam.rawValue]!)"
        }
        return result
    }
    
    func getPrice() -> String {
        var result: String = ""
        if let playerData = playerData {
            result = playerData.Price
        }
        return result
    }
    
    func getMarketCap() -> String {
        var result: String = ""
        if let playerData = playerData {
            result += "MCap \(playerData.MarketCap)"
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
                        self?.clipsToBounds = true
                    }
                }
            }
        }
    }
}
