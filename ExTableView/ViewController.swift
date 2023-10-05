//
//  ViewController.swift
//  ExTableView
//
//  Created by 김종권 on 2023/10/05.
//

import UIKit

final class MyTableViewCell: UITableViewCell {
    static let id = "MyTableViewCell"
    private let label = {
        let label = UILabel()
        label.text = "label1234"
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(text: "")
    }
    
    func prepare(text: String) {
        label.text = text
    }
}


class ViewController: UIViewController {
    private let tableView = {
        let view = UITableView()
        view.separatorStyle = .none
        view.bounces = true
        view.showsVerticalScrollIndicator = true
        view.contentInset = .zero
        view.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.id)
        view.estimatedRowHeight = 34
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var dataSource = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blue.cgColor, UIColor.green.cgColor]
        gradientLayer.frame = tableView.bounds
        
        let gradientBackgroundView = UIView()
        gradientBackgroundView.layer.addSublayer(gradientLayer)
        tableView.backgroundView = gradientBackgroundView
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.dataSource = (1...100).map(String.init)
            self.tableView.reloadData()
        })
    }

    private func setupUI() {
//        let thumbnailView = UIImageView(image: UIImage(systemName: "circle"))
//        tableView.backgroundView = thumbnailView
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.id, for: indexPath) as! MyTableViewCell
        cell.prepare(text: dataSource[indexPath.row])
        return cell
    }
}
