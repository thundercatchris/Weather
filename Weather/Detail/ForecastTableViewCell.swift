//
//  ForecastTableViewCell.swift
//  Weather
//
//  Created by Cerebro on 20/06/2018.
//  Copyright © 2018 thundercatchris. All rights reserved.
//

import UIKit
import Foundation

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    
    var forecast:Forecast?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setupCell() {
        if let significantWeather = forecast?.significantweather, let temp = forecast?.screentemp, let precip = forecast?.precipitation, let wind = forecast?.wind {
            weatherImage.image = UIImage(named: significantWeather)
            weatherImage.tintColor = UIColor.white
            tempLabel.attributedText = multipleSizeString(text: ( temp + "°C"), lastCharacters: 2)
            windLabel.attributedText = multipleSizeString(text: (wind + "mph"), lastCharacters: 3)
            precipLabel.attributedText = multipleSizeString(text: (precip + "%"), lastCharacters: 1)
        }
    }
    
    func multipleSizeString(text:String, lastCharacters: Int) -> NSMutableAttributedString {
        let amountText = NSMutableAttributedString.init(string: text)
        let count = text.count
        let startingIndex = (count - lastCharacters)
        for i in startingIndex...(count - 1){
              amountText.setAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12)], range: NSMakeRange(i, 1))
        }
        return amountText
    }
    
    override func prepareForReuse() {
        weatherImage.image = nil
        tempLabel.text = nil
        precipLabel.text = nil
        windLabel.text = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
