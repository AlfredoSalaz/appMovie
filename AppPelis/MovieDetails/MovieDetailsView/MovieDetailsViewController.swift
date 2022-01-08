//
//  MovieDetailsViewController.swift
//  AppPelis
//
//  Created by Alfredo Salazar on 07/01/22.
//

import UIKit
import MediaPlayer
import AVKit
import LinkPresentation
class MovieDetailsViewController: UIViewController, MovieDetailsViewControllerProtocol {
    
   var id: String?
    
    
    var presenter: MovieDetailsPresenterProtocol?
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var titleMovie: UILabel!
    @IBOutlet weak var dateMovie: UILabel!
    @IBOutlet weak var descriptionMovie: UILabel!
    
    @IBOutlet weak var viewVideo: UIView!
    @IBOutlet weak var stackVideo: UIStackView!
    @IBOutlet weak var stackImageView: UIStackView!
    @IBOutlet weak var statusMovie: UILabel!
    @IBOutlet weak var languajeMovie: UILabel!
    @IBOutlet weak var productionCompanyMoview: UILabel!
    
    var datailVideo: DetailVideoUrl?
    
    var urlKey = "https://www.youtube.com/watch?v=dDNhtB7L8Lk"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.getDetailMovie(id: self.id ?? "0")
        presenter?.getVideoUrl(id: id!)
        stackVideo.isHidden = true
    }
    ///Funcion que se ejecuta cuando se realizo de manera exitosa la peticion a los detalles de las peliculas
    /// - Parameter data: Contiene la informacion detallada de la pelicula
    func getSuccessData(data: DetailMoview) {
        if data.id == nil || data.id == 0 {
            
        }else{
        let urlString = Constant.urlImage + (data.backdrop_path)!
        var languageText = ""
        var companyText = ""
        print("urlstring", urlString)
        imageMovie.load(urlString: urlString)
        titleMovie.text = data.title
        dateMovie.text = data.release_date
        descriptionMovie.text = data.overview
        data.spoken_languages.forEach{
            languageText += " \($0.name ?? ""), "
        }
        data.production_companies.forEach{
            companyText += "\($0.name ?? ""), "
        }
        productionCompanyMoview.text = "Company: \(companyText)"
        languajeMovie.text = "Language: \(languageText)"
        statusMovie.text = "Status: \(data.status ?? "")"
        }
    }
    ///Funcion que se ejecuta cuando se realizo de manera exitosa la peticion a la url del video de la pelicula
    /// - Parameter url: Contiene la iinformacion del video de la pelicula
    func loadUrlVideo(url: DetailVideoUrl) {
        
        datailVideo = url
        
        let count = (datailVideo?.results.count)!
        if count > 1{
            urlKey = (datailVideo?.results[1].key)!
        } else{
            datailVideo?.results.forEach{
                urlKey = $0.key!
            }
        }
        
    }
    
    ///Accion del boton "Ver video"
    @IBAction func viewVideo(_ sender: Any) {
        stackImageView.isHidden = true
        stackVideo.isHidden = false
        urlKey = "\(Constant.urlYoutube)\(urlKey)"
        print("URL", urlKey)
        playVideo()
    }
    ///Funcion que lanza una vista que obtiene metadatos en tiempo real para ser usado
    func playVideo() {
        guard let url = URL(string: urlKey) else{
            return
        }
        let linkPreview = LPLinkView()
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url){ [weak self] metaData, error in
            guard let data = metaData, error == nil else{
                return
            }
            DispatchQueue.main.sync {
                linkPreview.metadata = data
                self!.viewVideo.addSubview(linkPreview)
                linkPreview.frame = CGRect(x: 0, y: 0, width: 414, height: 350)
                linkPreview.center = self?.viewVideo.center ?? .zero
            }
        }
        
    }
}
