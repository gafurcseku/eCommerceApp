//
//  BIError.swift
//  DhamakaShopping
//
//  Created by Invariant on 2/2/21.
//

import Foundation

enum DSError: Int {
    case unauthorized   = 401
    case notFound       = 404
    case timeOut        = 408
    case preconditioned = 412
    case invalidParam   = 422
    case serverProblem  = 500
}

