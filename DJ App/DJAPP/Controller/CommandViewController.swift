//
//  CommandViewController.swift
//  DjuP
//
//  Created by Arthur de Kerhor on 09/05/2018.
//  Copyright © 2018 Arthur de Kerhor. All rights reserved.
//

import UIKit

class CommandViewController: UIViewController {
    
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var styleButton: UIButton!
    @IBOutlet weak var numberButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var board: ResearchBoard!
    var filter = Filter.shared
    
    var minHeaderHeight: CGFloat {
        return board.minHeaderHeight
    }
    var midHeaderHeight: CGFloat {
        return board.midHeaderHeight
    }
    var maxHeaderHeight: CGFloat {
        return board.maxHeaderHeight
    }
    
    
    @IBOutlet weak var boardHeightConstraint: NSLayoutConstraint!
    
    var previousScrollOffset: CGFloat = 0
    var isHiddenStatusBar: Bool = false
    var statusBarStyle: UIStatusBarStyle = .lightContent
    
    
    var DJs = [DJ]()
    var filteredDJs = [DJ]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        DJs = [
            DJ(name:"Dirty Swift", price: 89, photoNames: ["dirtySwift2", "dirtySwift3", "dirtySwift"], style : "Electro", city : "Lyon", stars : "4stars_rating" , comments  : 121, dispos:"mercredi : 22h-4h \ndimanche : 23h-4h", description : "Dirty swift c’est d’abords une histoire de partage. L’amour de la musique est une part de lui-meme. En decouvrant le travail d’un DJ de légende comme Deejay Funk Master Flex, il su que les possibilités de créations musicales étaient infini et qu’il pouvait apporter quelque chose de différent. Ses influences ont fait la différence. Si le Hip-Hop reste sa passion première; aujourd’hui Dirty swift peut jouer de tout. Electro, House, Dubstep, Trap, Reggae, Dancehall, Soul, Funk et musique africaine. Révélé par les énormes soirées Hip Hop Love Soul, il n’a pas cessé de monter les échelons de la notoriété et de faire évoluer sa musique. Depuis ce jour il est devenu un DJ emblématique des nuits parisiennes, sont nom est devenu indissociable des établissements de nuits parisiens les plus prestigieux.", IndexOfPhoto : 0),
            DJ(name:"TABZ", price: 120, photoNames: ["tabz_presentationDJ_350x200"], style : "Drum & Bass / Deep House", city : "Palaiseau", stars : "5stars_rating" , comments  : 78, dispos : "jeudi : 22h-4h \nvendredi : 1h-6h \nsamedi : 00h-5h", description : "Tabz, originaire de Paris, excelle dans l’Acid Techno, l‘Acid House et le Speedcore. Ses multiples influences industrielle, tribale et alternative offrent au public une musique de qualité, sa bonne humeur et son soucis du spectacle font que ses prestations ne sont jamais les mêmes. Il évolue librement entre ses différents styles, suivant l'ambiance du public et son humeur du soir... ou du matin… Après des débuts dans l’ingénierie système son, c'est tout naturellement que Tabz se dirige vers la musique et le deejaying, avec sa révélation sur les scènes étudiantes de la région Parisienne.", IndexOfPhoto : 0),
            DJ(name:"DJ Banner", price: 115, photoNames: ["banner"], style : "Dance", city : "Paris", stars : "5stars_rating" , comments  : 35, dispos : "mardi : 22h-4h \njeudi : 1h-6h \nsamedi : 00h-5h", description : "DJ Banner, qui nous vient du New Jersey, s’est installé à Paris en 2013, pour travailler avec une grande station de radio. Habitués des scènes Parisiennes et des boiler rooms, il possède aussi une grande expérience dans les évènements privés. Ses sets de musique house, latino et hip-hop old school alimentent  la ferveur de la foule tant qu’il est sur scène. A la recherche de nouveaux publics et de nouveaux défis où exercer son talent, il est bien déterminer à faire de ses prestations des évènements mémorables.", IndexOfPhoto : 0),
            DJ(name:"DJL", price: 76, photoNames: ["DJL"], style : "Electro House/ Future House", city : "Paris", stars : "3stars_rating" , comments  : 27, dispos : "jeudi : 22h-4h \nvendredi : 1h-6h \nsamedi : 00h-5h", description : "Depuis plus de 8 ans maintenant, DJ L travaille ses sets inspirés par les soirées undergrounds Parisiennes. Extrêmement influencé par les années 70 quand à l'univers psychédélique dont il rappel souvent quelques vinyles en soirée, il ne sait ce poser dans un seul style et propose des sets variés et originaux à son public. Brasseur de profession, il partage sa passion de la musique par ses podcasts sur SoundCloud.", IndexOfPhoto : 0),
            DJ(name:"Gabin Noujeira", price: 89, photoNames: ["Gabin Noujeira"], style : "Techno / Trance", city : "Lyon", stars : "4stars_rating" , comments  : 56, dispos : "mercredi : 00h-4h \njeudi : 1h-4h \ndimanche : 1h-5h", description : "Gabin Noujeira, Dj originaire de la région parisienne est passionné de mix depuis plus d’une dizaine d’années. Ayant grandi dans le sud de la France, il commence ses premiers sets dans des bars de la Côte d’Azur, où il exerce ses talents et travaille la qualité de ses sets EDM et New Beat. Grâce à ses mix originaux et éclectiques, il vous réserve des prestations originales et de qualité, gardant l’esprit des soirées estivales de la French Riviera.", IndexOfPhoto : 0),
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let dayFormat = DateFormatter()
        dayFormat.dateFormat = "E d MMM yyyy HH:mm"
        locationButton.setTitle(filter.location, for: .normal)
        dateButton.setTitle(dayFormat.string(from: filter.date), for: .normal)
        if filter.Style["Tous"]! {filter.styleString = "Tous les styles"}
        else {
            filter.styleString = ""
            for (style, bool) in filter.Style{
                if bool {
                    filter.styleString += style + " "
                }
            }
        }
        if filter.styleString == "" {filter.styleString = "Tous les styles"}
        styleButton.setTitle(filter.styleString, for: .normal)
        numberButton.setTitle(filter.numberOfPeople, for : .normal)
    }
    
    @IBAction private func handleCollapse(){
        didCollapseHeader(completion: nil)
    }
    
    @IBAction private func handleExpand() {
        didExpandHeader(completion: nil)
    }
    
    func didCollapseHeader(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            let oldHeight = self.board.frame.size.height
            self.boardHeightConstraint!.constant = self.midHeaderHeight
            self.board.updateHeader(newHeight: self.midHeaderHeight, offset: self.midHeaderHeight - oldHeight)
        })
    }
    
    func didExpandHeader(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.2, animations: {
            let oldHeight = self.board.frame.size.height
            self.boardHeightConstraint!.constant = self.maxHeaderHeight
            self.board.updateHeader(newHeight: self.maxHeaderHeight, offset: self.maxHeaderHeight - oldHeight)
        })
    }
}
    
extension CommandViewController  : UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Scroll du menu filtrant
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let absoluteTop: CGFloat = 0
        let absoluteBottom: CGFloat = max(0, scrollView.contentSize.height - scrollView.frame.height)
        
        let scrollDif = scrollView.contentOffset.y - previousScrollOffset
        let isScrollUp = scrollDif < 0 && scrollView.contentOffset.y < absoluteBottom   // swipe down - header expands
        let isScrollDown = scrollDif > 0 && scrollView.contentOffset.y > absoluteTop    // swipe up - header shrinks
        
        var newHeight = boardHeightConstraint!.constant
        if isScrollUp {
            newHeight = min(maxHeaderHeight, (boardHeightConstraint!.constant + abs(scrollDif)))
        } else if isScrollDown {
            newHeight = max(minHeaderHeight, (boardHeightConstraint!.constant - abs(scrollDif)))
        }
        
        if newHeight != boardHeightConstraint!.constant {
            boardHeightConstraint?.constant = newHeight
            board.updateHeader(newHeight: newHeight, offset: scrollDif)
            setScrollPosition(scrollView, toPosition: previousScrollOffset)
            updateStatusBar()
        }
        
        previousScrollOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling(scrollView)
        }
    }
    
    func setScrollPosition(_ scrollView: UIScrollView, toPosition position: CGFloat) {
        scrollView.contentOffset = CGPoint(x: scrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidStopScrolling(_ scrollView: UIScrollView) {
        let curHeight = boardHeightConstraint!.constant
        if curHeight < midHeaderHeight {
            setHeaderHeight(scrollView, height: minHeaderHeight)
        } else if curHeight < maxHeaderHeight - board.headerInputHeight {
            setHeaderHeight(scrollView, height: midHeaderHeight)
        } else {
            setHeaderHeight(scrollView, height: maxHeaderHeight)
        }
        
        updateStatusBar()
    }
    
    func setHeaderHeight(_ scrollView: UIScrollView, height: CGFloat) {
       
        UIView.animate(withDuration: 0.2, animations: {
            self.boardHeightConstraint?.constant = height
            self.board.updateHeader(newHeight: height, offset: scrollView.contentOffset.y - self.previousScrollOffset)
        })
    }
    
    func setStatusBarHidden(_ isHidden: Bool, withStyle style: UIStatusBarStyle) {
        if isHidden != isHiddenStatusBar || statusBarStyle != style {
            statusBarStyle = style
            isHiddenStatusBar = isHidden
            
            UIView.animate(withDuration: 0.5, animations: {
                self.updateStatusBar()
            })
        }
    }
    
    func updateStatusBar() {
        let curHeight = boardHeightConstraint!.constant
        if curHeight == minHeaderHeight {
            setStatusBarHidden(false, withStyle: .default)
        } else if curHeight > minHeaderHeight, curHeight < midHeaderHeight {
            setStatusBarHidden(true, withStyle: .lightContent)
        } else {
            setStatusBarHidden(false, withStyle: .lightContent)
        }
    }
    
    // MARK: - Affichage DJs
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func isFiltering() -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDJs.count
        }
        
        return DJs.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : DJCellView = tableView.dequeueReusableCell(withIdentifier: "DJCell", for: indexPath) as! DJCellView
        let dj: DJ
        if isFiltering() {
            dj = filteredDJs[indexPath.row]
        } else {
            dj = DJs[indexPath.row]
        }
        
        cell.updateCell(with : dj)
        return cell
    }
    
    internal func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let dj :DJ
        if isFiltering() {
            dj = filteredDJs[indexPath.row]
        } else {
            dj = DJs[indexPath.row]
        }
        DJ.shared = dj
        return indexPath
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        tableView.reloadData()
    }
}


