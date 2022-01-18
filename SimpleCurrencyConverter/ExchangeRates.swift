//
//  ExchangeRates.swift
//  SimpleCurrencyConverter
//
//  Created by Blazej Wietczak on 18/01/2022.
//

import Foundation

struct ExchangeRates: Codable{
    let rates: [String: Double]
}
