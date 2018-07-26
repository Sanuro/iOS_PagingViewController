//
//  HomeVC.swift
//  ExampleParchment
//
//  Created by Jaewon Lee on 7/26/18.
//  Copyright © 2018 Jaewon Lee. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {



    @IBOutlet var rando: [UIImageView]!
    @IBOutlet var annotation: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        for i in 0...3 {
            getDoggy(index: i)
        }
    }
    
    func getDoggy(index: Int) {
    //         specify the url that we will be sending the GET request to
        let url = URL(string: "https://dog.ceo/api/breeds/image/random")
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
                        if status == "success" {
                            if let message = jsonResult["message"] as? String {
                                var breed_name = message.components(separatedBy: "/")
                                print(breed_name)
                                let urlmsg = URL(string: message)
                                let data = try? Data(contentsOf: urlmsg!)
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    DispatchQueue.main.async {
                                        self.rando[index].image = image
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
//        let url = URL(string: "https://images.dog.ceo/breeds/rottweiler/n02106550_13213.jpg")
//        let data = try? Data(contentsOf: url!)
//
//        if let imageData = data {
//            let image = UIImage(data: imageData)
//            return image
//        }
//    }
}
