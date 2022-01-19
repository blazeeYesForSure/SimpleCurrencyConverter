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
            if let doubleAmountText = Double(amountText){
                convertedAmountUsd = doubleAmountText * rateUsdCurrency
                inputAmountEur = amountText
                priceLabel.text = String(format: "%.2f", convertedAmountUsd)
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    self.popUpAlert(convertedAmountUsd: self.convertedAmountUsd, inputAmountEur: self.inputAmountEur)
                }
            }
            else{
                priceLabel.text = "Twoja kwota w USD"
                    self.popUpAlert()
            }
        }

    }
    
    
    // MARK: - Properties
    var rateUsdCurrency = 0.0
    var convertedAmountUsd = 0.0
    var inputAmountEur = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetechJSON()
    }

    //MARK: - Methods
    func fetechJSON() {
        guard let url = URL(string: "https://open.er-api.com/v6/latest/EUR") else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { [self](data,response, error) in
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
        }
        dataTask.resume()
    }
    
    func popUpAlert(convertedAmountUsd:Double, inputAmountEur:String) {
        let alert = UIAlertController(title: "Wymiana", message: inputAmountEur + "EUR" + " to " + String(format: "%.2f", convertedAmountUsd) + "USD", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: {action in print("tapped OK")}))
        present(alert, animated: true)
    }
    
    func popUpAlert() {
        let alert = UIAlertController(title: "BŁĄD!", message: "Wprowadź poprawne dane!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Poprawiam", style: .destructive, handler: {action in print("tapped Poprawiam")}))
        present(alert, animated: true)
    }
    
}
