//
//  VariationFormsAcronym.swift
//  DecoderAbbreviation
//
//  Created by Tatiana Ampilogova on 8/1/22.
//

import UIKit

class VariationFormsAcronym: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var variationForm: AcronymDetails
    private lazy var tableView = UITableView()
    
    init(variationForm: AcronymDetails) {
        self.variationForm = variationForm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        self.title = "Variation forms"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeAction))
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: view.frame, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(VariationFormsCell.self, forCellReuseIdentifier: "AcronymsCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variationForm.variations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcronymsCell", for: indexPath) as! VariationFormsCell
        let model = variationForm.variations[indexPath.row]
        cell.configure(with: model)
        return cell
    }
    
    @objc private func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
}
