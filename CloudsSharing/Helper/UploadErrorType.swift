//
//  UploadErrorType.swift
//  CloudsSharing
//
//  Created by Mihail Șalari on 1/10/17.
//  Copyright © 2017 Mihail Șalari. All rights reserved.
//

import Foundation

enum UploadErrorType: Error {
    case succes(String)
    case failed(String)
    case errorMove(String)
}
