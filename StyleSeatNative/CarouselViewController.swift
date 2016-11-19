//
//  CarouselViewController.swift
//  StyleSeatNative
//
//  Created by Carlos Canas on 11/17/16.
//  Copyright © 2016 Carlos Canas. All rights reserved.
//

import UIKit

class CarouselViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carouselControl: UIPageControl!
    @IBOutlet weak var scrollContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: 1875, height: 667)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissButtonDidTap(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page : Int = Int(round(scrollView.contentOffset.x / 375))
        
        carouselControl.currentPage = page
        
        //        if pageControl.currentPage == 4 {
        //
        //            UIView.animateWithDuration(0.3, animations: { () -> Void in
        //                self.pageControl.alpha = 0
        //
        //                self.backupSpinButtonContainer.alpha = 1
        //            })
        //
        //        } else {
        //            UIView.animateWithDuration(0.3, animations: { () -> Void in
        //                self.pageControl.alpha = 1
        //                self.backupSpinButtonContainer.alpha = 0
        //            })
        //        }
        
        
    }
    
    func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
        let ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    
    // MARK: scrollViewDidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = CGFloat(scrollView.contentOffset.y)

        let contentFade = convertValue(value: offset, r1Min: 0, r1Max: -160, r2Min: 1, r2Max: 0)
        
        scrollContainer.alpha = contentFade
        
        
        // Couple
        
        if scrollView.contentOffset.y < -160 {
           
            
            dismiss(animated: true, completion: nil)
            
            
        }
        
        print("content offset \(scrollView.contentOffset.y)")
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
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
