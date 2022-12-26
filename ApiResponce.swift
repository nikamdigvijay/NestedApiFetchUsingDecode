//
//  ApiResponce.swift
//  ProductDecoderApi
//
//  Created by Digvijay Nikam on 14/12/22.
//

import Foundation

struct ApiResponce : Decodable{
    var products : [Product]
}
struct Product : Decodable{
    var id : Int
    var title : String
    var description : String
    var price : Double
    var discountPercentage : Double
    var rating : Double
    var stock : Int
    var brand : String
}
