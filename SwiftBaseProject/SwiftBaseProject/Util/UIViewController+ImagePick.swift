//
//  UIViewController+ImagePick.swift
//  SwiftBaseProject
//
//  Created by 张永杰 on 2021/2/20.
//  Copyright © 2021 张永杰. All rights reserved.
//
import Foundation
import UIKit
import MobileCoreServices
import AVFoundation
import Photos

extension UIViewController {
    @objc func choosePhotoFromLibrary(allowsEdidting: Bool){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            photoLibraryRequestAuthorization { [weak self] (isAuthorized) in
                if isAuthorized {
                    self?.pickViewController(type: UIImagePickerController.SourceType.photoLibrary, allowsEdidting: allowsEdidting)
                }
            }

        }else{
            presentAlert(title: "Error",
                         message: "The device does not support albums",
                         buttonTitle: "OK")
        }
    }

    @objc func chooseVidoeFromLibrary(allowsEdidting: Bool){
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            photoLibraryRequestAuthorization { [weak self] (isAuthorized) in
                if isAuthorized {
                    self?.pickViewController(type: .photoLibrary, mideaTypes: [String(kUTTypeMovie)], allowsEdidting: allowsEdidting)
                }
            }
            
        }else{
            presentAlert(title: "Error",
                         message: "The device does not support albums",
                         buttonTitle: "OK")
        }
    }

    @objc func takePhoto(allowsEdidting: Bool) {
  
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            videoRequestAuthorization { [weak self] (isAuthorized) in
                if isAuthorized {
                    self?.pickViewController(type: UIImagePickerController.SourceType.camera, allowsEdidting: allowsEdidting)
                }
            }
            
        }else{
            presentAlert(title: "Error",
                         message: "The device does not support the camera",
                         buttonTitle: "OK")
        }
    }
       
    func pickViewController(type: UIImagePickerController.SourceType, mideaTypes: [String] = [String(kUTTypeImage)], allowsEdidting: Bool) {

        let imagePickController = UIImagePickerController()
        imagePickController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickController.mediaTypes = mideaTypes
        imagePickController.allowsEditing = allowsEdidting
        imagePickController.sourceType = type
        imagePickController.videoMaximumDuration = 30.0
        present(imagePickController, animated: true, completion: nil)
    }
    
    public func photoLibraryRequestAuthorization(isAuthorized:@escaping ((Bool)->Void)) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .notDetermined {
            PHPhotoLibrary.requestAuthorization { (status) in
                if status == .authorized {
                    isAuthorized(true)
                }else{
                    isAuthorized(false)
                }
            }
        }else if status == .authorized{
            isAuthorized(true)
        }else{
            isAuthorized(false)
            self.presentAlert(title: "Allow this app to access your album on Settings-privacy-photos on your iPhone")
        }
    }
    
    public func videoRequestAuthorization(isAuthorized:@escaping ((Bool)->Void)) {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video) { (isRight) in
                isAuthorized(isRight)
            }
        }else if status == .authorized {
            isAuthorized(true)
        }else{
            isAuthorized(false)
            self.presentAlert(title: "Allow this app to access your camera on Settings-privacy on your iPhone")
        }
        
    }
    
}
