//
//  IssueVIewController.swift
//  Co-Make
//
//  Created by Luqmaan Khan on 7/29/19.
//  Copyright © 2019 Luqmaan Khan. All rights reserved.
//

import UIKit

class IssueVIewController: UIViewController {

    @IBOutlet var imageCollectionView: UICollectionView!
    
    @IBOutlet var imagePageControl: UIPageControl!
    
    
    var images = [ UIImage(named: "sign-in-4"),UIImage(named: "sign-up-5"), UIImage(named: "sign-up-6")]
    
    
    var currentImagePageIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePageControl.numberOfPages = images.count
    }
    
    
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

extension IssueVIewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: imageCollectionView.frame.width, height: imageCollectionView.frame.height)
    }
  
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentImagePageIndex = Int(scrollView.contentOffset.x / imageCollectionView.frame.size.width)
    imagePageControl.currentPage = currentImagePageIndex
    }

}

extension IssueVIewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = imageCollectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell else {return UICollectionViewCell()}
        
      let image = images[indexPath.item]
        cell.image = image
        return cell
        
    }
    
   


}
