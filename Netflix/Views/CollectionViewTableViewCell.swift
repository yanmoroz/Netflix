//
//  CollectionViewTableViewCell.swift
//  Netflix
//
//  Created by Yan Moroz on 04.01.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel)
}

final class CollectionViewTableViewCell: UITableViewCell {
    private var titles = [Title]()
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellWithClass: TitleCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model = titles[indexPath.item].posterPath else {
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withClass: TitleCollectionViewCell.self, for: indexPath)
        cell.configure(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.item]
        guard let titleName = title.originalTitle ?? title.name else {
            return
        }
        
        APICaller.shared.getMovie(with: "\(titleName) trailer") { [weak self] result in
            switch result {
            case .success(let videoElement):
                guard let self = self else { return }
                guard let titleOverview = self.titles[indexPath.item].overview else {
                    return
                }
                
                let viewModel = TitlePreviewViewModel(
                    title: titleName,
                    youtubeView: videoElement,
                    titleOverview: titleOverview
                )
                self.delegate?.collectionViewTableViewCellDidTapCell(self, viewModel: viewModel)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
 
