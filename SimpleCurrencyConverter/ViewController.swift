//
//  ViewController.swift
//  SimpleCurrencyConverter
//
//  Created by Blazej Wietczak on 17/01/2022.
//

import UIKit


class ViewController: UIViewController{

    // MARK: - IBOutlets
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - IBActions
    @IBAction func Convertbutton(_ sender: Any) {
    }
    // MARK: - Properties
    var rateUsdCurrency = 0.0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetechJSON()
    }

    //MARK: - Method
    func fetechJSON() {
        guard let url = URL(string: "https://open.er-api.com/v6/latest/EUR") else {return}
        URLSession.shared.dataTask(with: url) { [self](data,response, error) in
            //handle any errors if there are any
            if error != nil  {
                print(error!)
                return
            }
            //safely unwrap the data
            guard let safeData = data else {return}
            
            //decode the JSON data
            do{
                let results = try JSONDecoder().decode(ExchangeRates.self, from: safeData)
                rateUsdCurrency = results.rates["USD"]!
                print(rateUsdCurrency)
                }
            catch{
                print(error)
                
            }
        }.resume()
    }    
}
