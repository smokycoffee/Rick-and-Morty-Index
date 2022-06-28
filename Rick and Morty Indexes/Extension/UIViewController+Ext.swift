//
//  UIViewController+EXt.swift
//  Rick and Morty Indexes
//
//  Created by Tsenguun on 24/6/22.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {

    func showLoading(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemTeal
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25, animations: {containerView.alpha = 0.8})
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoading() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
//            containerView = nil
        }
    }
    
}
