//
//  BreedsListResponse.swift
//  RAnDog
//
//  Created by Abdalah on 11/3/1440 AH.
//  Copyright © 1440 AH Abdalah. All rights reserved.
//

import Foundation
struct BreedsListResponse :Codable {
    let status: String
    let message: [String: [String]]
}
