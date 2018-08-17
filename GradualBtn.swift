//
//  GradualBtn.swift
//  CloudscmGuoda
//
//  Created by RexYoung on 2017/6/22.
//  Copyright © 2017年 RexYoung. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class GradualBtn: UIView {
    
    var tapClosure: (() -> ())?
    
    var btn: UIButton!
    
    var clickObseverable = PublishSubject<Void>()
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: KScreenWidth - 60, height: 54)
        gradientLayer.colors = [UIColor.navStartColor.cgColor, UIColor.tangerine.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        return gradientLayer
    }()
        
    //控制按钮是否可点击
    var isEnable = false {
        didSet {
            //1.控制阴影的显示与隐藏
            textImg.isHidden = !isEnable
            //2.控制渐变色
//            gradientLayer.colors = isEnable ? [UIColor.plnOrange.cgColor, UIColor.tangerine.cgColor] : [UIColor.plnOrange50.cgColor, UIColor.tangerine50.cgColor]
            bgView.alpha = isEnable ? 1 : 0.5
            
            btn.isEnabled = isEnable
        }
    }
    
    lazy var bgView: UIView = {
        //创建bgview
        let bgView = UIView()
        bgView.clipsToBounds = true
        bgView.layer.cornerRadius = 27
        return bgView
    }()
    
    lazy var textImg: UIImageView = {
        let textImg = UIImageView()
        var imageN = UIImage(named: "shadow_login_btn")?.imageWithTintColor(color: UIColor.tangerine)
        let edgeInset = UIEdgeInsets(top: 12, left: 12, bottom: 10, right: 10)
        imageN = imageN?.resizableImage(withCapInsets: edgeInset, resizingMode: .stretch)
        textImg.image = imageN
        return textImg
    }()
    
    init(frame: CGRect, startColor: UIColor = UIColor.red, endColor: UIColor = UIColor.green, title: String, btnColor: UIColor = UIColor.white) {
        super.init(frame: frame)
        addSubview(textImg)
        
        textImg.snp.makeConstraints { make in
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.top.bottom.equalTo(self)
        }

        addSubview(bgView)
        
        //按钮
        btn = UIButton()
        btn.titleLabel?.font = UIFont.smallTitle
        //设置按钮的颜色
        btn.setTitle(title, for: .normal)
        btn.titleLabel?.textColor = btnColor
        btn.clipsToBounds = true
        btn.layer.cornerRadius = 27
        btn.addTarget(self, action: #selector(doClick), for: .touchUpInside)
        addSubview(btn)
        
        bgView.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.right.equalTo(-30)
            make.top.equalTo(15)
            make.bottom.equalTo(-15)
        }
        
        btn.snp.makeConstraints { make in
            make.edges.equalTo(bgView)
        }
        
        //开启渐变
        //设置渐变色
        bgView.layer.addSublayer(gradientLayer)
//        gradual()
    }
    
    //按钮的点击事件
    @objc func doClick() {
//        if let closure = tapClosure {
//            closure()
//        }
        clickObseverable.onNext(())
    }
    
//    func gradual(startColor: UIColor = .plnOrange, endColor: UIColor = .tangerine) {
//        
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Reactive where Base: GradualBtn {
    var tap: ControlEvent<Void> {
        return ControlEvent<Void>(events: base.clickObseverable)
    }
    
    var isEnable: Binder<Bool> {
        return Binder(base){ (base, isEnable) in
            base.isEnable = isEnable
        }
    }
}
