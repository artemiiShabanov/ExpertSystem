//
//  Variant.swift
//  ExpertSystem
//
//  Created by Artemii Shabanov on 31.05.2021.
//

import Foundation

struct Variant: Hashable {
    var index: Int
    var name: String
}

struct VariantPair: Hashable {
    var variantRegardingWhich: Variant
    var variant: Variant
}
