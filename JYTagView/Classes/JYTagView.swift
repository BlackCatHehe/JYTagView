//
//  JYTagView.swift
//  TestSwiftKeyChain
//
//  Created by APP on 2019/8/30.
//  Copyright © 2019 APP. All rights reserved.
//

//只是提供一个tag自适应的功能，里面的组建完全由自己定义


import UIKit
import SnapKit
public class JYTagView: UIView {
    
    /// 是否为自动布局，如果不是,需要设置为false. 默认为true
    public var isAutoLayout: Bool = true
    
    /// tag数据源
    public var titles: [String] = []
    
    /// title的font,默认为14.0
    public var titleFont: UIFont = UIFont.systemFont(ofSize: 14.0)
    
    /// item的行间距,默认为5.0
    public var lineSpacing: CGFloat = 5.0
    
    /// item间距,默认为10.0
    public var itemSpacing: CGFloat = 10.0
    
    /// item的height,默认为30.0
    public var itemHeight: CGFloat = 30.0
    
    /// item的左右内间距,默认为5.0
    public var itemInsetPadding: CGFloat = 5.0
    
    /// item构造器，可以自定义item
    public var itemBuilder: ((Int)-> UIView)?
    
    /// 左上角的一个功能性组建button,默认不存在（一般用来设置点击折叠）
    public var moreButton: UIButton?
    
    private var isMore: Bool = false
}

public extension JYTagView {
    
    /// 设置完数据源和构造器后调用,之后每次更改数据源或者构造器都需要调用
    public func reloadData() {

        assert(itemBuilder != nil, "itemBuilder canot be nil, please set itemBuilder with items")
        
        for subV in self.subviews {
            subV.removeFromSuperview()
        }
        
        //如果有moreButton,则先设置morebutton
        if let moreBt = moreButton {
            self.addSubview(moreBt)
            moreBt.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.right.equalToSuperview().offset(-10.0)
                make.height.equalTo(itemHeight)
            }
        }
        
        //self如果是自动布局的话，需要先layoutSubviews来确定自己的frame
        if isAutoLayout == true {
            layoutSubviews()
        }
        
        var row: Int = 0 //
        
        var tagX: CGFloat = 0
        var tagY: CGFloat = 0
        
        for i in 0..<titles.count {
            let title = titles[i]
            
            //计算出title的宽度 这里要加上两边的内边距
            let bWidth = title.jy_getSizeWith(font: titleFont, maxSize: CGSize(width: self.frame.width, height: itemHeight)).width + 2*itemInsetPadding
            
            //如果有moreButton,则第一行的宽度需要加上moreBt来判断
            if let moreBt = moreButton, row == 0 {
                if (tagX + bWidth + moreBt.frame.width + 40.0) > self.frame.width {
                    row += 1
                    tagX = 0
                    tagY += lineSpacing + itemHeight
                }
            }else {
                if (tagX + bWidth) > self.frame.width {
                    row += 1
                    tagX = 0
                    tagY += lineSpacing + itemHeight
                }
            }
            let item = self.itemBuilder!(i)

            addSubview(item)
            item.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(tagX)
                make.top.equalToSuperview().offset(tagY)
                make.width.equalTo(bWidth)
                if i == titles.count - 1 , self.isAutoLayout == true{
                    make.bottom.equalToSuperview()
                }
            }
            tagX += bWidth + itemSpacing
        }
    }

}
