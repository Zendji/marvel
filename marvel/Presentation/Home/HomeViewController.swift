//
//  HomeViewController.swift
//  marvel
//
//  Created by Zendji Mizoguchi on 07/08/18.
//  Copyright © 2018 Zendji Mizoguchi. All rights reserved.
//

import UIKit
import Hero

class HomeViewController: UIViewController {
    
    private lazy var homeManager = HomeManager(delegate: self)
    
    private var heroList = [Result]()
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        setupTable()
        homeManager.getHeroes()
    }
    
    func setupTable() {
        tableView?.dataSource = self
        tableView?.delegate = self
    }
    
    func setupCells() {
        tableView?.register(UINib(nibName: "HeroCell", bundle: nil), forCellReuseIdentifier: "HeroCell")
    }
}

extension HomeViewController: HomeDelegate {
    
    func sucess(heros: [Result]) {
        self.heroList.insert(contentsOf: heros, at: self.heroList.count)
        tableView?.reloadData()
        self.view.layoutIfNeeded()
    }
    
    func error() {
        
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return heroList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView?.dequeueReusableCell(withIdentifier: "HeroCell", for: indexPath) as? HeroCell
        
        let hero = self.heroList[indexPath.row]
        cell?.setup(heroName: hero.name, descriptipn: hero.description, urlImage: hero.thumbnail)
        
        return cell ?? UITableViewCell()
    }
    
    
}

extension HomeViewController: UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let hero = heroList[indexPath.row]
        
        let vc = Bundle.main.loadNibNamed("DetailViewController", owner: self, options: nil)![0] as! DetailViewController
        vc.heroSelected = hero
        vc.hero.isEnabled = true
        self.present(vc, animated: true, completion: nil)

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == heroList.count {
            homeManager.getHeroes()
        }
    }
    
}
