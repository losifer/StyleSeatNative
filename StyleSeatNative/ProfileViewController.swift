//
//  ProfileViewController.swift
//  StyleSeatNative
//
//  Created by Carlos Canas on 11/17/16.
//  Copyright © 2016 Carlos Canas. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var carouselScrollView: UIScrollView!
    @IBOutlet weak var carouselControl: UIPageControl!
    @IBOutlet weak var cardScrollView: UIScrollView!
    @IBOutlet weak var profileOverlay: UIView!
    @IBOutlet weak var card: UIView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        profileOverlay.isHidden = true
        card.isHidden = true
        profileOverlay.layer.opacity = 0
        card.layer.opacity = 0
        card.layer.cornerRadius = 6
        
        carouselScrollView.delegate = self
        mainScrollView.delegate = self
        profileImage.layer.cornerRadius = 40
        carouselScrollView.contentSize = CGSize(width: 1875, height: 240)
        
        mainScrollView.contentSize = CGSize(width: 375, height: 1390)
        cardScrollView.contentSize = CGSize(width: 375, height: 1280)
        
    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let currentOffset = scrollView.contentOffset.x
//        
//        let finalOffset = scrollView.contentSize.width - scrollView.frame.width
//        
//        // print("Current Offset \(currentOffset) Final Offset \(finalOffset)")
//        
//        if scrollView == finalOffset {
//            pageControl.alpha = 0
//        }
//        
//    }
//    
    @IBAction func profileButton(_ sender: UITapGestureRecognizer) {
        self.profileOverlay.isHidden = false
        self.card.isHidden = false
        
                UIView.animate(withDuration: 0.2, animations: {
            self.card.alpha = 1
            self.profileOverlay.alpha = 1
        }, completion: { (Bool) in
            
                
            // ..

            
        })

        
        
    }
    @IBAction func backArrow(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func closeButton(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.2, animations: {
            self.card.alpha = 0
            self.profileOverlay.alpha = 0
        }, completion: { (Bool) in
            
            
            self.profileOverlay.isHidden = true
            self.card.isHidden = true
            
            
        })

    }
    
    @IBAction func carouselDidTap(_ sender: UITapGestureRecognizer) {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
