//
//  ViewController.swift
//  MobileiOSDevTestWork
//
//  Created by Larry Livingston on 07.06.2023.
//

import UIKit

class ViewController: UIViewController {
    private var tableViewController = TableViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Deals"

        addChild(tableViewController)
        view.addSubview(tableViewController.view)
        tableViewController.view.frame = view.safeAreaLayoutGuide.layoutFrame
        tableViewController.didMove(toParent: self)
        setupCustomButton()
        
        
    }
    
    
    private func setupCustomButton() {
        let arrowButtonButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(changeSortButtonTapped))
        navigationItem.rightBarButtonItem = arrowButtonButtonItem
    }
    
    @objc func changeSortButtonTapped() {
        let alertController = UIAlertController(title: "Change Sort", message: "Select sort field and direction", preferredStyle: .actionSheet)
        for field in SortField.allCases {
            let action = UIAlertAction(title: field.rawValue.capitalized, style: .default) { [weak self] _ in
                self?.showSortDirectionAlert(field: field)
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func showSortDirectionAlert(field: SortField) {
        let alertController = UIAlertController(title: "Sort Direction", message: "Select sort direction", preferredStyle: .actionSheet)
        
        let ascendingAction = UIAlertAction(title: "Ascending", style: .default) { [weak self] _ in
            self?.tableViewController.changeSort(field: field, direction: .ascending)
        }
        let descendingAction = UIAlertAction(title: "Descending", style: .default) { [weak self] _ in
            self?.tableViewController.changeSort(field: field, direction: .descending)
        }
        alertController.addAction(ascendingAction)
        alertController.addAction(descendingAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    

}

