
//  Created by rasul on 3/26/20.
//  Copyright © 2020 Rasl. All rights reserved.
//

import Foundation

typealias ItemClosure<T> = ((T) -> Void)
typealias VoidClosure = (() -> Void)
typealias ItemClosureReturn<T> = (() -> T)
typealias CompletionBlock<T: Decodable, U: Error> = (Result<T, U>) -> Void
typealias CompletionDataBlock = (Result<Data, APIError>) -> Void
