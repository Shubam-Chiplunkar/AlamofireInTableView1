//
//  ViewController.swift
//  AlamofireInTableView1
//
//  Created by mayank ranka on 08/04/23.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   
    @IBOutlet weak var myTableView: UITableView!
    
    var dataID = [Any]()
    var dataTitle = [Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.myTableView.delegate = self
        self.myTableView.dataSource = self
        let url = "https://jsonplaceholder.typicode.com/posts"
        
        AF.request(url , method: .get).responseJSON {  (response) in
            switch response.result{
            case .success:
//                print(response.result)
                do{
                    let res = try JSON(data: response.data!)
                    let jsonData = res[]
                    for i in jsonData.arrayValue{
                        let valID = i["id"]
                        self.dataID.append(valID)
//                        print(self.dataID.count)
                        let valTitle = i["title"]
                        self.dataTitle.append(valTitle)
                    }
                    self.myTableView.reloadData()

                }catch{
                    
                }
                break
            case .failure:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataID.count)
        return dataID.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(dataID[indexPath.row])"
        cell.detailTextLabel?.text = "\(dataTitle[indexPath.row])"
        return cell
    }


}

