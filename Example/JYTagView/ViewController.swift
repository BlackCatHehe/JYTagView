//
//  ViewController.swift
//  JYTagView
//
//  Created by 462497072@qq.com on 09/04/2019.
//  Copyright (c) 2019 462497072@qq.com. All rights reserved.
//

import UIKit
import JYTagView
class ViewController: UIViewController {

    private var tagView: JYTagView!
    
    private var isMore: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTagView()
    }

    func initTagView() {
        
        let titles = [
            "视频认证", "学历认证", "手机认证", "身份证认证", "驾照认证", "存折认证"
        ]
        
        let tagV = JYTagView()
        tagV.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 200.0)
        tagV.backgroundColor = .gray
        tagV.clipsToBounds = true
        //  tagV.isAutoLayout = false
        tagV.titles = titles
        tagV.moreButton = {[weak self] in
            let tagBt = UIButton()
            tagBt.setTitle("更多>", for: .normal)
            tagBt.setTitleColor(.white, for: .normal)
            tagBt.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            tagBt.layer.borderColor = UIColor.orange.cgColor
            tagBt.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
            return tagBt
            }()
        tagV.itemBuilder = {(index) in
            let tagBt = UIButton()
            tagBt.setTitle(titles[index], for: .normal)
            tagBt.setTitleColor(.orange, for: .normal)
            tagBt.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            tagBt.layer.cornerRadius = 15.0
            tagBt.layer.masksToBounds = true
            tagBt.layer.borderWidth = 1.0
            tagBt.layer.borderColor = UIColor.orange.cgColor
            tagBt.tag = index + 100
            return tagBt
        }
        view.addSubview(tagV)
        
        tagV.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(200.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
        }
        
        tagView = tagV
        tagV.reloadData()
    }
    
    @objc private func clickMore() {
        
        isMore = !isMore
        
        if isMore == true {
            //            var frame = tagView.frame
            //            frame.size.height = 200
            //            tagView.frame = frame
            
            tagView.snp.remakeConstraints{(make) in
                make.top.equalToSuperview().offset(200.0)
                make.left.equalToSuperview().offset(20.0)
                make.right.equalToSuperview().offset(-20.0)
            }
        }else {
            //            var frame = tagView.frame
            //            frame.size.height = 30.0
            //            tagView.frame = frame
            tagView.snp.remakeConstraints{(make) in
                make.top.equalToSuperview().offset(200.0)
                make.left.equalToSuperview().offset(20.0)
                make.right.equalToSuperview().offset(-20.0)
                make.height.equalTo(30.0)
            }
        }
    }

}

