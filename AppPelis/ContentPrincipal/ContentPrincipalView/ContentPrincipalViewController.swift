//
//  ContentPrincipalViewController.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 06/01/22.
//

import UIKit

class ContentPrincipalViewController: UIViewController, ContentPrincipalViewControllerProtocol {
    
    
    var presenter: ContentPrincipalPresenterProtocol?
    
    @IBOutlet weak var textSearch: UITextField!
    var listaPlayingNow: PlayingNow?
    var listaPopular: PlayingNow?
    
    @IBOutlet weak var collectionViewPlayingNow: UICollectionView!
    @IBOutlet weak var collectionViewMostPopular: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionViewPlayingNow.delegate = self
        self.collectionViewPlayingNow.dataSource = self
        presenter?.getPlayingNow()
        presenter?.getMostPopular()
    }
    ///Funcion que se ejecuta por parte del protocolo desdepues de recibir el ws
    /// - Parameter list: Contiene la lista de los  datos obtenidos del ws
    func successDataPlayingNow(list: PlayingNow) {
        self.listaPlayingNow = list
        collectionViewPlayingNow.reloadData()
    }
    //Accion del Boton de SearchMovie
    @IBAction func getPlayingNow(_ sender: Any) {
        var text = textSearch.text
        text = text?.replacingOccurrences(of: " ", with: "+")
        presenter?.goSearchMovie(text: text!)
    }
    ///Funcion que se ejecuta por parte del protocolo desdepues de recibir el ws
    /// - Parameter list: Contiene la lista de los  datos obtenidos del ws
    func successFulDataPopular(list: PlayingNow) {
        self.listaPopular = list
        collectionViewMostPopular.reloadData()
    }
    ///Funcion que llama al ws para obtener los detalles de la pelicula
    /// - Parameter id: Contiene el id de la pelicula a consultar
    func loadDetailsMovie(id: Int ){
        presenter?.getDetailsMovie(string: String(id))
    }
    
}
// MARK: Contiene las funciones de los delegados del CollectionView
extension ContentPrincipalViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let lista = listaPlayingNow?.results{
            return lista.count
        }
        if let listaPopular = listaPopular?.results{
            return listaPopular.count
        }
        else{
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case collectionViewPlayingNow:
            let cell = collectionViewPlayingNow.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
            let data = listaPlayingNow?.results[indexPath.row]
            let urlString = Constant.urlImage + (data?.backdrop_path!)!
            print("urlstring", urlString)
            cell.imageMovie.load(urlString: urlString)
            cell.lblNameMovie.text = data?.title!
            if let id = data?.id{
                cell.funcActionImage = { self.loadDetailsMovie(id: id)}
            }
            return cell
        case collectionViewMostPopular:
            print("HI")
            let cell = collectionViewMostPopular.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
            let data = listaPopular?.results[indexPath.row]
            let urlString = Constant.urlImage + (data?.backdrop_path!)!
            print("urlstring", urlString)
            cell.imageMovie.load(urlString: urlString)
            cell.lblNameMovie.text = data?.title!
            if let id = data?.id{
                cell.funcActionImage = { self.loadDetailsMovie( id: id)}
            }
            return cell
        default: break
        }
        return UICollectionViewCell.init()
    }

    
}

extension UIImageView {
    ///Funcion que procesa la url en string para convertirlo en una url donde ontendra la url completa de la imegn
    /// - Parameter urlString: Url en string
    func load(urlString : String) {
        guard let url = URL(string: urlString)else {
            return
        }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
