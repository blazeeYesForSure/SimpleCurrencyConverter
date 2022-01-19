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
        if let amountText = textField.text{
            if let theAmountText = Double(amountText){
                total = theAmountText * rateUsdCurrency
                myAmountText = amountText
                priceLabel.text = String(format: "%.2f", total)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            self.popUpAlert(total: self.total, amountText: self.myAmountText)
        }
    }
    
    // MARK: - Properties
    var rateUsdCurrency = 0.0
    var total = 0.0
    var myAmountText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetechJSON()
    }

    //MARK: - Methods
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
                }
            catch{
                print(error)
                
            }
        }.resume()
    }
    
    func popUpAlert(total:Double, amountText:String) {
        let alert = UIAlertController(title: "Wymiana", message: amountText + "USD" + " to " + String(format: "%.2f", total) + "EUR", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in print("tapped OK")}))
        present(alert, animated: true)
    }
    
}
