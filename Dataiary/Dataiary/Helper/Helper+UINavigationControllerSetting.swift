//
//  Helper+UINavigationControllerSetting.swift
//  Dataiary
//
//  Created by 김민준 on 4/11/24.
//

import UIKit

extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
    
    /// Pop Gesture를 인식하고 전달하는 delegate 위임
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
}
