//
//  ProtocolWithGenericMethods.swift
//  Mocky_Example
//
//  Created by przemyslaw.wosko on 04/11/2017.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import Foundation

protocol ProtocolWithGenericMethods {
    func exampleMethod<T: Equatable>(elements: [T]) -> [T]
}
