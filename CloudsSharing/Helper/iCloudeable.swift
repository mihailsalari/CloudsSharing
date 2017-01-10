//
//  iCloudeable.swift
//  CloudsSharing
//
//  Created by Mihail Șalari on 1/10/17.
//  Copyright © 2017 Mihail Șalari. All rights reserved.
//

import Foundation

protocol iCloudeable: FileManagereable {
    var cloudURL: URL? { get }
    var iCloudDocumentsURL: URL? { get }
    
    func saveFileToiCloud(_ documentURL: URL)
    func saveFileToiCloud(_ documentURL: URL, completion: @escaping (Bool, UploadErrorType) -> ())
}


// MARK: - Properties

extension iCloudeable {
    
    var cloudURL: URL? {
        return filesManager.url(forUbiquityContainerIdentifier: nil)
    }
    
    var iCloudDocumentsURL: URL? {
        return cloudURL?.appendingPathComponent("Documents")
    }
}


// MARK: - Check iCloud aviability

extension iCloudeable {
    
    fileprivate func checkiCloudAviability(_ completion: @escaping (Bool) -> ()) {
        OperationQueue().addOperation { _ in
            if self.cloudURL != nil {
                OperationQueue.main.addOperation {
                    completion(true)
                }
            } else {
                OperationQueue.main.addOperation {
                    completion(false)
                }
            }
        }
    }
}


// MARK: - Save file

extension iCloudeable {
    
    func saveFileToiCloud(_ documentURL: URL) {
        
        if let destinationURL = self.iCloudDocumentsURL?.appendingPathComponent(documentURL.lastPathComponent) {
            print(destinationURL)
            do {
                let dataImage = try Data(contentsOf: documentURL)
                try dataImage.write(to: destinationURL)
                
            } catch {
                print("Error moving \(documentURL) to storage \(destinationURL)")
            }
        }
    }
    
    func saveFileToiCloud(_ documentURL: URL, completion: @escaping (Bool, UploadErrorType) -> ()) {
        
        self.checkiCloudAviability { (succes) in
            if succes {
                if let destinationURL = self.iCloudDocumentsURL?.appendingPathComponent(documentURL.lastPathComponent) {
                    do {
                        let dataImage = try Data(contentsOf: documentURL)
                        try dataImage.write(to: destinationURL)
                        
                        completion(true, UploadErrorType.succes("Succes"))
                    } catch {
                        print("Error moving \(documentURL) to storage \(destinationURL)")
                        completion(false, UploadErrorType.errorMove("Error moving \(documentURL) to storage \(destinationURL)"))
                    }
                }
            } else {
                completion(true, UploadErrorType.failed("Failed"))
            }
        }
    }
}
