//
//  HomeVC.swift
//  ExampleParchment
//
//  Created by Jaewon Lee on 7/26/18.
//  Copyright © 2018 Jaewon Lee. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    var searchActive : Bool = false

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var rando: [UIImageView]!
    @IBOutlet var annotation: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        searchBar.delegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getDoggy(url:"https://dog.ceo/api/breeds/image/random/4")
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        getDoggy(url:"https://dog.ceo/api/breeds/image/random/4")
//    }
    
    func getDoggy(url : String) {
        var breedname: [String] = []
    //         specify the url that we will be sending the GET request to
        let url = URL(string: url)
        // create a URLSession to handle the request tasks
        let session = URLSession.shared
        // create a "data task" to make the request and run completion handler
        let task = session.dataTask(with: url!, completionHandler: {
            // see: Swift closure expression syntax
            data, response, error in
            // data -> JSON data, response -> headers and other meta-information, error-> if one occurred
            // "do-try-catch" blocks execute a try statement and then use the catch statement for errors
            do {
                // try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let status = jsonResult["status"] as? String {
                        print(jsonResult)
                        if status == "success" {
                            if let message = jsonResult["message"] as? NSArray {
                                for i in 0...3{
                                    let msg = message[i] as! String
                
                                    breedname.append(msg.components(separatedBy: "/")[4])
                                    print(breedname)
                                    let urlmsg = URL(string: msg)
                                    let data = try? Data(contentsOf: urlmsg!)
                                    if let imageData = data {
                                        DispatchQueue.main.async {
                                            let image = UIImage(data: imageData)
                                            self.rando[i].image = image
                                            let right_left = breedname[i].components(separatedBy: "-")
                                            var real_name = right_left[0]
                                            if right_left.count > 1 {
                                                real_name = right_left[1] + " " + right_left[0]
                                            }
                                            let real_name1 = real_name.capitalized
                                            self.annotation[i].text = real_name1
                                        }
                                    }
                                }
                                
                                
                                
                                
                                print(message)
                            }
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
        // execute the task and then wait for the response
        // to run the completion handler. This is async!
        task.resume()
    }
}

extension HomeVC: UISearchBarDelegate{
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // if searchActive == true{
        let lowercase = searchText.lowercased()
        let right_left = lowercase.components(separatedBy: " ")
        var stringurl = ""
        stringurl = right_left[0]
        if right_left.count > 1 {
            stringurl = right_left[1] + "/" + right_left[0]
        }
        getDoggy(url:"https://dog.ceo/api/breed/" + stringurl + "/images")
//        print("we in the if yo")
        

        print(searchText)
    }
    
    
}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



