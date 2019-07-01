//
//  MuralDetailViewController.swift
//  CityArt
//
//  Created by Colin Smith on 6/20/19.
//  Copyright © 2019 Colin Smith. All rights reserved.
//

import UIKit

class MuralDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var yearInstalledLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var artworkDescriptionLabel: UILabel!
    
    var mural: Mural?{
        didSet{
            loadViewIfNeeded()
            updateViews()
        }
    }
    var tour: Tour?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        
    }

    func updateViews(){
        titleLabel.text = mural?.title
        artistLabel.text = mural?.artist
        yearInstalledLabel.text = mural?.yearInstalled
        streetLabel.text = mural?.streetAddress
        artworkDescriptionLabel.text = mural?.artworkDescription
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TourController.shared.tours.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tourCell", for: indexPath)
        cell.textLabel?.text = TourController.shared.tours[indexPath.row].title
        return cell
    }
    
    
    @IBAction func addToFavoritesPressed(_ sender: UIButton) {
        guard let mural = mural else {return}
        FavoritesController.shared.favorites.append(mural)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @IBAction func addToToursButtonPressed(_ sender: UIButton) {
        //Present an AlertViewController that will display the tour list in a table view
        let tourAlert = UIAlertController(title: "Select a Tour", message: nil, preferredStyle: .alert)
        let tourTableView = UITableView()
        tourTableView.delegate = self
        tourTableView.dataSource = self
        tourTableView.backgroundColor = .lightGray
        tourTableView.sizeThatFits(CGSize(width: 200, height: 200))
        tourTableView.center = tourAlert.view.center
        tourAlert.view.addSubview(tourTableView)
        
        
        let addAction = UIAlertAction(title: "Add", style: .default) { (add) in
            guard let mural = self.mural,
                let tour = self.tour else {return}
            TourController.shared.addToTour(tour: tour, mural: mural)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            tourAlert.dismiss(animated: true, completion: nil)
        }
        tourAlert.addAction(cancelAction)
        tourAlert.addAction(addAction)
        
        present(tourAlert, animated: true) {
            
            guard let chosen = tourTableView.indexPathForSelectedRow else {return}
            self.tour = TourController.shared.tours[chosen.row]
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
   */
 
}