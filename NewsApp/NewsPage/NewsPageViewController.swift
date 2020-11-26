//
//  NewsPageViewController.swift
//  NewsApp
//
//  Created by V on 26.11.2020.
//

import UIKit
import SnapKit
import WebKit

class NewsPageViewController: UIViewController {
    
    var news: News! {
        didSet {
            url = news.url
        }
    }
    
    private var webpage: WKWebView!
    private var url: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        webpage = WKWebView()
        self.view.addSubview(webpage)
        webpage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        webpage.load(url ?? "apple.com")
    }
}

extension WKWebView {
    func load(_ url: String) {
        if let url = URL(string: url) {
            let req = URLRequest(url: url)
            load(req)
        }
    }
}
