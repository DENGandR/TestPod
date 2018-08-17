//
//  GradientLabel.swift
//  Memo
//
//  Created by RexYoung on 2017/8/7.
//  Copyright © 2017年 RexYoung. All rights reserved.
//

import UIKit

class GradientLabel: UIView {

    var label: UILabel!
    var detail: UILabel!
    
    var clickClosure: (() -> ())?
    
    lazy var gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.frame = self.label.frame
        gradient.colors = [UIColor.navStartColor.cgColor, UIColor.tangerine.cgColor]
        return gradient
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //用户协议
    func userProtocol() {
        let btn = UIButton(type: .system)
        btn.setTitle("《千帆用户协议》", for: .normal)
        btn.backgroundColor = .white
        btn.setTitleColor(.lightBlue, for: .normal)
        btn.titleLabel?.font = UIFont.text
        btn.addTarget(self, action: #selector(doRead), for: .touchUpInside)
        addSubview(btn)
        btn.snp.makeConstraints { make in
            make.left.equalTo(detail.snp.right).offset(2)
            make.centerY.equalTo(detail)
        }
    }
    
    //读取用户协议
    @objc func doRead() {
        guard let closure = clickClosure else { return }
        closure()
    }
    
    //绑定值
    func binding(title: String, content: String) {
        label.text = title
        detail.text = content
    }
    
    func initView() {
        label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26).Medium()
        addSubview(label)
        label.snp.makeConstraints { make in
            make.left.top.equalTo(self)
        }
        
        detail = UILabel()
        detail.font = UIFont.text
        detail.textColor = UIColor.greyish
        addSubview(detail)
        detail.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.top.equalTo(label.snp.bottom).offset(4)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.addSublayer(gradientLayer)
        gradientLayer.mask = self.label.layer
    }

}
