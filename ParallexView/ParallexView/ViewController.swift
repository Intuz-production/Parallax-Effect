//The MIT License (MIT)
//
//Copyright (c) 2020 INTUZ
//
//Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var screenTitleLbl: UILabel!
    @IBOutlet weak var headerview: UIView!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var scrollTopSpacingConstant: NSLayoutConstraint!
    @IBOutlet weak var headerviewHeightConstraint: NSLayoutConstraint! ///headerView height constraint
    
    let statusHeight:CGFloat = 20
    let scrollTopEdgeInsets:CGFloat = (SF.screenHeight/3) ///scrollView Top insets size
    let scrolViewCornerRadius:CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    //MARK:- private Method
    private func setupUI() {
        self.scrollTopSpacingConstant.constant = self.topbarHeight
        self.headerviewHeightConstraint.constant = self.topbarHeight
        scrView.delegate = self
        scrView.layer.cornerRadius = scrolViewCornerRadius
        scrView.layer.masksToBounds = true
        scrView.contentInset = UIEdgeInsets(top: scrollTopEdgeInsets, left: 0, bottom: 0, right: 0)
    }
}

//MARK: UIScrollViewDelegate
extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let minHeight:CGFloat = self.topbarHeight
        let maxHeight:CGFloat = (SF.screenHeight/3)+minHeight
        let yPos = scrView.contentOffset.y
        let headerViewHeight = (maxHeight - yPos)-(maxHeight-minHeight)
        let titleValue = headerViewHeight-minHeight
        ///set screen title alpha value
        if(titleValue > 0){
            let finalValue = titleValue*100/scrollTopEdgeInsets
            let alphaValue = finalValue/100
            screenTitleLbl.alpha = 1-alphaValue
        }
//        ///manage Header Height
        if (headerViewHeight > maxHeight) {
            headerviewHeightConstraint.constant = (max(headerViewHeight, maxHeight)) + scrolViewCornerRadius
        } else {
            headerviewHeightConstraint.constant = (max(headerViewHeight, minHeight)) + scrolViewCornerRadius
        }
    }
}
