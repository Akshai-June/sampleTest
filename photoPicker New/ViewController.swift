//
//  ViewController.swift
//  photoPicker New
//
//  Created by Akshai's Mac on 17/01/23.
//

import UIKit
import PhotosUI

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource, PHPickerViewControllerDelegate {
    @IBOutlet weak var collOutlt: UICollectionView!
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self){object, error
                in
                if let image = object as? UIImage{
                    self.imageArray.append(image)
                    
                }
                DispatchQueue.main.async {
                    self.collOutlt.reloadData()
                }
            }
        }
    }
    
    var imageArray = [UIImage]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "New", for: indexPath) as! NewCollectionViewCell
        cell.imgoUtlt.image = imageArray[indexPath.row]
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
    }


    @IBAction func plusBtnGotPressed(_ sender: UIBarButtonItem) {
        var config  = PHPickerConfiguration()
        config.selectionLimit = 3
        let phPickerVc = PHPickerViewController(configuration: config)
        phPickerVc.delegate = self
        self.present(phPickerVc, animated: true)
        
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width/3, height: collectionView.frame.size.height/5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
