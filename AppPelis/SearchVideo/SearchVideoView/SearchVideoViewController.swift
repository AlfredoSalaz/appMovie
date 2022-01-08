//
//  SearchVideoViewController.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import UIKit

class SearchVideoViewController: UIViewController, SearchVideoViewControllerProtocol {
    
    var text: String?
    var presenter: SearchVideoPresenterProtocol?
    var listMovie: SearchMovie?
    
    
    @IBOutlet weak var tableSearchResult: UITableView!
    @IBOutlet weak var heightTableSearch: NSLayoutConstraint!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("text formed", text)
        presenter?.searchMovies(text: text!)
        tableSearchResult.delegate = self
        tableSearchResult.dataSource = self
    }

    func onSetDataView(data: SearchMovie) {
        print("here")
        listMovie = data
        tableSearchResult.reloadData()
        
        
    }
    func goDetailView(id: Int){
        presenter?.goDetailMovie(id: String(id))
    }
    
    
}
extension SearchVideoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data = listMovie{
            return data.results.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableSearchResult.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchResultCell
        let data = listMovie?.results[indexPath.row]
        if let image =  data?.poster_path{
            let urlString = Constant.urlImage + (image)
            print("urlstring", urlString)
            cell.imageMovie.load(urlString: urlString)
        }else{
            if let ima = data?.backdrop_path{
                let urlString = Constant.urlImage + (ima)
                print("urlstring", urlString)
                cell.imageMovie.load(urlString: urlString)
            }
        }
        
        cell.lLblTitle.text = data?.title
        cell.lblDescription.text = data?.overview
        cell.detailMovie = {
            self.goDetailView(id: (data?.id!)!)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableSearchResult.layoutIfNeeded()
        heightTableSearch.constant = tableSearchResult.contentSize.height
    }
    
}
