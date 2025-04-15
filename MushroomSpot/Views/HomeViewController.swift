//
//  HomeViewController.swift
//  MushroomSpot
//
//  Created by Apple on 14/04/25.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = HomeViewModel()
    private let loader = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
          super.viewDidLoad()

          // Register custom cell
          let nib = UINib(nibName: "MushroomCell", bundle: nil)
          tableView.register(nib, forCellReuseIdentifier: "MushroomCell")

          tableView.delegate = self
          tableView.dataSource = self
          tableView.rowHeight = UITableView.automaticDimension
          tableView.estimatedRowHeight = 100

          // Setup loader
          loader.translatesAutoresizingMaskIntoConstraints = false
          loader.hidesWhenStopped = true
          view.addSubview(loader)
          NSLayoutConstraint.activate([
              loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
              loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
          ])
          loader.startAnimating()

          // Bind ViewModel
          viewModel.onDataLoaded = {
              DispatchQueue.main.async {
                  self.loader.stopAnimating()
                  self.tableView.reloadData()
              }
          }

          viewModel.onError = { message in
              DispatchQueue.main.async {
                  self.loader.stopAnimating()
                  print("❌ \(message)")
              }
          }

          viewModel.fetchMushrooms()
      }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return viewModel.count
      }

      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let mushroom = viewModel.mushroom(at: indexPath.row)

          guard let cell = tableView.dequeueReusableCell(withIdentifier: "MushroomCell", for: indexPath) as? MushroomCell else {
              return UITableViewCell()
          }

          cell.nameLabel.text = mushroom.name
          cell.latinNameLabel.text = mushroom.latin_name
          cell.idLabel.text = "ID: \(mushroom.id)"
          cell.mushroomImageView.image = nil

          if let url = URL(string: mushroom.profile_picture) {
              DispatchQueue.global().async {
                  if let data = try? Data(contentsOf: url) {
                      DispatchQueue.main.async {
                          cell.mushroomImageView.image = UIImage(data: data)
                      }
                  }
              }
          }

          return cell
      }

      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let detailVC = MushroomDetailViewController(nibName: "MushroomDetailViewController", bundle: nil)
          detailVC.mushroom = viewModel.mushroom(at: indexPath.row)
          navigationController?.pushViewController(detailVC, animated: true)
      }
  }
