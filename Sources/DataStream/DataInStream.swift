//
//  DataInStream.swift
//  server
//
//  Created by Bernardo Breder on 03/12/16.
//  Copyright © 2016 Breder Company. All rights reserved.
//

import Foundation

enum DataInStreamError: Error {
    case noReaderAssigned
}

open class DataInStream {

    internal var data: Data = Data()
    
    internal var index: Data.Index = 0
    
    public var reader: () throws -> Data
    
    public init(reader: @escaping () throws -> Data) {
        self.reader = reader
    }
    
    public func read() throws -> UInt8 {
        if empty {
            data = try reader()
            index = data.startIndex
        }
        let byte = data[index]
        index = index.advanced(by: 1)
        return byte
    }
    
    public var empty: Bool {
        return index >= data.endIndex
    }

}
