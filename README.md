# JYTagView

[![CI Status](https://img.shields.io/travis/462497072@qq.com/JYTagView.svg?style=flat)](https://travis-ci.org/462497072@qq.com/JYTagView)
[![Version](https://img.shields.io/cocoapods/v/JYTagView.svg?style=flat)](https://cocoapods.org/pods/JYTagView)
[![License](https://img.shields.io/cocoapods/l/JYTagView.svg?style=flat)](https://cocoapods.org/pods/JYTagView)
[![Platform](https://img.shields.io/cocoapods/p/JYTagView.svg?style=flat)](https://cocoapods.org/pods/JYTagView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JYTagView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JYTagView'
```
## language
```ruby
swift
```

## use
```ruby
let tagV = JYTagView()
tagV.backgroundColor = .gray
tagV.frame = CGRect(x: 20, y: 200, width: view.bounds.width - 40, height: 200.0)

//支持frame和autolayout两种方式，推荐使用snapkit自动布局，能自适应高度。如果是frame布局，需要传入
tagV.isAutoLayout = false

//设置标签数据源
tagV.titles = ["视频认证", "学历认证", "手机认证", "身份证认证", "驾照认证", "存折认证"]

//传入自定义样式的右上角按钮，如果不设置则默认不会显示（该按钮我常用来设置点击折叠打开）
tagV.moreButton = {[weak self] in
            let tagBt = UIButton()
            tagBt.setTitle("更多>", for: .normal)
            tagBt.setTitleColor(.white, for: .normal)
            tagBt.titleLabel?.font = UIFont.systemFont(ofSize: 14.0)
            tagBt.layer.borderColor = UIColor.orange.cgColor
            tagBt.addTarget(self, action: #selector(clickMore), for: .touchUpInside)
            return tagBt
            }()
            
//如果你也需要设置折叠视图，记着设置
tagV.clipsToBounds = true

//必须设置标签构造器，传入自定义样式的标签      
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
//添加到视图
view.addSubview(tagV)

//如果使用Snakpit
tagV.snp.makeConstraints{(make) in
            make.top.equalToSuperview().offset(200.0)
            make.left.equalToSuperview().offset(20.0)
            make.right.equalToSuperview().offset(-20.0)
        }
        
//数据源设置完毕，刷新视图布局
tagV.reloadData()

//右上角按钮的点击事件
@objc private func clickMore() {
        
        isMore = !isMore//一个用于判断是否为折叠状态的Bool
        
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
```


## Author

BlackCatHehe, 462497072@qq.com

## License

JYTagView is available under the MIT license. See the LICENSE file for more info.
