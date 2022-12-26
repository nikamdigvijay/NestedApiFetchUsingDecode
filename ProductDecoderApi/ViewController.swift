//
//  ViewController.swift
//  ProductDecoderApi
//
//  Created by Digvijay Nikam on 14/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var FVCTableView: UITableView!
    
    var api = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNib()
        dataAndDelegate()
        dataFromApi(){
            self.FVCTableView.reloadData()
        }
    }
    
//MARK:- UINibregister
    
    func registerNib(){
        let uinib = UINib(nibName: "ProductTableViewCell", bundle: nil)
        FVCTableView.register(uinib, forCellReuseIdentifier: "ProductTableViewCell")
    }
    
//MARK:- DataAndDelegate
    
    func dataAndDelegate(){
        FVCTableView.dataSource = self
        FVCTableView.delegate = self
    }
    
//MARK:- Data FetchFromApi Using Decode
    
    func dataFromApi(completed: @escaping () -> () ){
        let url = URL(string: "https://dummyjson.com/products")
        
        URLSession.shared.dataTask(with: url!) {data, responce, error in
            print(data)
            print(error)
            
            let productApi = try! JSONDecoder().decode(ApiResponce.self, from: data!)
            self.api = productApi.products
            
            DispatchQueue.main.async {
                completed()
            }
            
        }.resume()
        
    }
}

//MARK:- Use UITableViewDataSource extention

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return api.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.FVCTableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as! ProductTableViewCell
        cell.idLabel.text = String(api[indexPath.row].id)
        cell.priceLabel.text = String(api[indexPath.row].price)
        cell.titleLabel.text = api[indexPath.row].title
        cell.descriptionLabel.text = api[indexPath.row].description
        cell.discountPercentageLabel.text = String(api[indexPath.row].discountPercentage)
        cell.ratingLabel.text = String(api[indexPath.row].rating)
        cell.stockLabel.text = String(api[indexPath.row].stock)
        cell.brandLabel.text = api[indexPath.row].brand
        return cell
    }
}

//MARK: Use UITableViewDelegate extension

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}

