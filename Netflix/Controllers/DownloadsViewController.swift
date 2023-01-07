//
//  DownloadsViewController.swift
//  Netflix
//
//  Created by Yan Moroz on 04.01.2023.
//

import UIKit

final class DownloadsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = .systemBackground
    }
}
