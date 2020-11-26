//
//  ViewController.swift
//  NewsApp
//
//  Created by V on 26.11.2020.
//

import UIKit
import SnapKit
import RealmSwift

class NewsTableViewController: UIViewController {

    private var vm: NewsTabelViewModelProtocol!
    private var tv: UITableView!
    private var res: Results<News>!
    private var token: NotificationToken?

    override func viewDidLoad() {
        super.viewDidLoad()
        vm = NewsTableViewModel()
        tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.isHidden = true
        refreshData()
        token = res.observe({[weak self] (changes) in
            guard let tv = self?.tv else { return }
            switch changes {
            case .initial(_):
                print("init changes case")
            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                tv.beginUpdates()
                tv.deleteRows(at: deletions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tv.insertRows(at: insertions.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tv.reloadRows(at: modifications.map({ IndexPath(row: $0, section: 0)}), with: .automatic)
                tv.endUpdates()
            case .error(_):
                fatalError()
            }
        })
        initUI()
    }
    
    private func initUI() {
        self.view.addSubview(tv)
        tv.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        self.tv.rowHeight = 70
    }
    
    @objc private func refreshData() {
        vm.fetchData()
        res = vm.retriveData()
        tv.isHidden = false
        //token?.invalidate()
    }
}

extension NewsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return res.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = NewsCell()
        if indexPath.row < res.count {
            cell.data = res[indexPath.row]
            return cell
        } else {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tv.deselectRow(at: indexPath, animated: true)
        let newsPage = NewsPageViewController()
        newsPage.news = res[indexPath.row]
        self.present(newsPage, animated: true)
    }
}

