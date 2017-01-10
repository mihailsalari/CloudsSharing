//
//  ShareViewController.swift
//  CloudsSharing
//
//  Created by Mihail Șalari on 12/24/16.
//  Copyright © 2016 Mihail Șalari. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var exportLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.rgb(red: 66.0, green: 66.0, blue: 66.0, alpha: 1.0)
        label.text = "Export as:"
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var convertorSegmentedControl: UISegmentedControl = {
        let segment = UISegmentedControl()
        segment.insertSegment(withTitle: "Image", at: 0, animated: true)
        segment.insertSegment(withTitle: "PDF", at: 1, animated: true)
        segment.tintColor = UIColor.customBlue
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(fileTypeSegmentTapped(_:)), for: .valueChanged)
        
        return segment
    }()
    
    
    // MARK: - LyfeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



extension ShareViewController {
    
    @IBAction func shareTapped(_ sender: UIBarButtonItem) {
       self.prepareSharingController()
    }
}


extension ShareViewController {
    
    fileprivate func prepareSharingController() {
        let alertController = UIAlertController(title: "Share", message: "Share to clouds", preferredStyle: .actionSheet)
        
        ///
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        alertController.view.addSubview(headerView)
        alertController.view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: headerView)
        alertController.view.addConstraintsWithFormat("V:|-57-[v0(26)]", views: headerView)
        ///

        ///
        headerView.addSubview(exportLabel)
        headerView.addSubview(convertorSegmentedControl)
        
        headerView.addConstraintsWithFormat("H:|-4-[v0(60)]-10-[v1]-4-|", views: exportLabel, convertorSegmentedControl)
        headerView.addConstraintsWithFormat("V:|-2-[v0]-2-|", views: exportLabel)
        headerView.addConstraintsWithFormat("V:|-2-[v0]-2-|", views: convertorSegmentedControl)
        
        
        ///
        let cancel = UIAlertAction(title: SharingType.cancel.rawValue.capitalized, style: .cancel, handler: nil)
        
        let dropBox = UIAlertAction(title: SharingType.dropbox.rawValue.capitalized, style: .default) { [unowned self] (action) in
            self.shareByType(.dropbox)
        }
        
        let googleDrive = UIAlertAction(title: SharingType.googleDrive.rawValue.capitalized, style: .default) { [unowned self] (action) in
            self.shareByType(.googleDrive)
        }
        
        let evernote = UIAlertAction(title: SharingType.evernote.rawValue.capitalized, style: .default) { [unowned self] (action) in
            self.shareByType(.evernote)
        }
        
        let iCloud = UIAlertAction(title: SharingType.iCloud.rawValue, style: .default) { [unowned self] (action) in
            self.shareByType(.iCloud)
        }
        
        let yandexDisk = UIAlertAction(title: SharingType.yandexDisk.rawValue.capitalized, style: .default) { [unowned self] (action) in
            self.shareByType(.yandexDisk)
        }
        
        let box = UIAlertAction(title: SharingType.box.rawValue.capitalized, style: .default) { [unowned self] (action) in
            self.shareByType(.box)
        }
        
        alertController.addAction(cancel)
        alertController.addAction(dropBox)
        alertController.addAction(googleDrive)
        alertController.addAction(evernote)
        alertController.addAction(iCloud)
        alertController.addAction(yandexDisk)
        alertController.addAction(box)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


extension ShareViewController {
    
    @objc fileprivate func fileTypeSegmentTapped(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            print("Text PDF")
            
        case 1:
            print("Just text")
        default:
            break
        }
    }
}


extension ShareViewController: iCloudeable {
    
    fileprivate func shareByType(_ type: SharingType) {
        switch type {
        case .dropbox:
            print("Drop")
        case .googleDrive:
            print("Google")
        case .evernote:
            print("evernote")
        case .iCloud:
            print("iCloud")

            if let path = Bundle.main.path(forResource: "265174", ofType: "png") {
                if let imageURL = URL(string: "file://\(path)") {
                    self.saveFileToiCloud(imageURL)
                }
            }
            
        case .yandexDisk:
            print("yandexDisk")
        case .box:
            print("box")
        default:
            break
        }
    }
}










