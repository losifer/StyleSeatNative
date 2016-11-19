//
//  HomeViewController.swift
//  StyleSeatNative
//
//  Created by Sebastian Drew on 11/17/16.
//  Copyright © 2016 Carlos Canas. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    var screenOriginalCenter: CGPoint!
    
    var screenClosed: CGPoint!
    var screenOpen: CGPoint!
    
    var friction: CGFloat!
    
    var searchInitialY: CGFloat!
    var offset: CGFloat = -70

    @IBOutlet weak var topHeader: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchfield: UITextField!
    @IBOutlet weak var stickySearchField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stickySearchView: UIView!
    @IBOutlet weak var findAndBookLabel: UILabel!
    @IBOutlet weak var scrollViewContainer: UIView!
    @IBOutlet weak var navView: UIView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var overLayView: UIView!
    @IBOutlet weak var filtersButton: UIButton!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenClosed = CGPoint(x: 0, y: 0)
        screenOpen = CGPoint(x: 300, y: 0)
        
        overLayView.isHidden = true
        overLayView.layer.opacity = 0
        topHeader.layer.opacity = 0
        topHeader.isHidden = true
        
        navView.alpha = 0
        
        scrollViewContainer.frame.origin = screenClosed
        scrollViewContainer.layer.shadowOpacity = 0.4
        scrollViewContainer.layer.shadowOffset = CGSize(width: -2, height: 0)
        scrollViewContainer.layer.shadowRadius = 2
        
        friction = 10

        searchView.layer.cornerRadius = 20
        searchView.layer.borderWidth = 1
        searchView.layer.borderColor = UIColor.lightGray.cgColor
        stickySearchView.layer.cornerRadius = 20
        stickySearchView.layer.borderWidth = 1
        stickySearchView.layer.borderColor = UIColor.lightGray.cgColor
        
        filtersButton.layer.cornerRadius = 15
        filtersButton.layer.borderWidth = 1
        filtersButton.layer.borderColor = UIColor.lightGray.cgColor
        filtersButton.alpha = 0
        
        searchfield.delegate = self
        scrollView.delegate = self
        
        scrollView.contentSize = CGSize(width: 375, height: 2588)
        
        searchInitialY = searchView.frame.origin.y
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(HomeViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }


    func keyboardWillShow(_ notification: NSNotification) {
        overLayView.isHidden = false
        
        searchView.frame.origin = CGPoint(x: self.searchView.frame.origin.x, y: searchInitialY + offset)
        
//        UIView.animate(withDuration: 0.2) { 
//            self.findAndBookLabel.alpha = 0
//            self.overLayView.alpha = 0.96
//        }
        

            
            UIView.animate(withDuration: 0.2, animations: { 
                self.findAndBookLabel.alpha = 0
                self.overLayView.alpha = 0.96
            }, completion: { (Bool) in
                // ..
                UIView.animate(withDuration: 0.2, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    
                    self.filtersButton.center.y = 90
                    self.filtersButton.alpha = 1
                    
                }, completion: nil)
                
            })

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func keyboardWillHide(_ notification: NSNotification) {
        
        searchView.frame.origin = CGPoint(x: searchView.frame.origin.x, y: searchInitialY)
        UIView.animate(withDuration: 0.2) {
            self.findAndBookLabel.alpha = 1
            self.overLayView.alpha = 0
            self.filtersButton.center.y = 100
            self.filtersButton.alpha = 0
        }
        
        overLayView.isHidden = true
    }

    @IBAction func viewDidTap(_ sender: UITapGestureRecognizer) {
        searchfield.endEditing(true)
    }
    
    
    @IBAction func navDidTap(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.3) {
            self.scrollViewContainer.frame.origin.x = 260
             //self.scrollViewContainer.alpha = 0
            print ("Tapped")
        }
    }
    
  
    func convertValue(value: CGFloat, r1Min: CGFloat, r1Max: CGFloat, r2Min: CGFloat, r2Max: CGFloat) -> CGFloat {
        let ratio = (r2Max - r2Min) / (r1Max - r1Min)
        return value * ratio + r2Min - r1Min * ratio
    }
    
    @IBAction func onScreenPan(_ sender: UIPanGestureRecognizer) {
        
        // let location = panGestureRecognizer.locationInView(view)
        
        let translation = panGestureRecognizer.translation(in: view)
        
        let velocity = panGestureRecognizer.velocity(in: view)
        
        let contentScale = convertValue(value: scrollViewContainer.frame.origin.x, r1Min: 0, r1Max: 240, r2Min: 0.9, r2Max: 1.0)
        
        let contentFade = convertValue(value: scrollViewContainer.frame.origin.x, r1Min: 0, r1Max: 240, r2Min: 0, r2Max: 1.0)
        
        if panGestureRecognizer.state == UIGestureRecognizerState.began {
            
            
           screenOriginalCenter = scrollViewContainer.frame.origin
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.changed {
            
            scrollViewContainer.frame.origin = CGPoint(x: screenOriginalCenter.x + translation.x, y: screenOriginalCenter.y)

            
            navView.alpha = contentFade
            
            navView.transform = CGAffineTransform(scaleX: contentScale, y: contentScale)
            
            print ("Moving ", "\(scrollViewContainer.frame.origin.x)")
            print()
            
            
            
            
        } else if panGestureRecognizer.state == UIGestureRecognizerState.ended {
            
            if velocity.x > 0 {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.scrollViewContainer.frame.origin = self.screenOpen
                })
                
            } else {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.55, initialSpringVelocity: 0.7, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                    self.scrollViewContainer.frame.origin = self.screenClosed
                })
            }
            
            
            if scrollViewContainer.frame.origin.x > 260 {
                scrollView.isUserInteractionEnabled = false
            } else {
                scrollView.isUserInteractionEnabled = true
            }
        }
    }
    

    // MARK: scrollViewDidScroll
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        _ = CGFloat(scrollView.contentOffset.y)
        
        // Couple
        
        if scrollView.contentOffset.y > 71 {
            topHeader.isHidden = false
            
            UIView.animate(withDuration: 0, animations: {
                self.topHeader.layer.opacity = 100
            })
            
            
        } else {
            topHeader.isHidden = true
            
            UIView.animate(withDuration: 0.3, animations: {
                self.topHeader.layer.opacity = 0
            })

        }
        
        
        print("content offset \(scrollView.contentOffset.y)")
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // This method is called as the user scrolls
        
        
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // This method is called right as the user lifts their finger
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        // This method is called when the scrollview finally stops scrolling.
    }
    
    /*
     /Users/drew/Dropbox (Personal)/product/StyleSeatNative/StyleSeatNative/StyleSeatNative/Assets.xcassets/magnifyer.imageset/magnifyer.png
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
