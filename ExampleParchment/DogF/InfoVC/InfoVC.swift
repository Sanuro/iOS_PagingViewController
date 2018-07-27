

import UIKit
import CoreData

class InfoVC: UIViewController{
    var tableData: [Breed] = []
    var dogBreedName = ""
    
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func infoVCSwipe(_ sender: UISwipeGestureRecognizer) {
        performSegue(withIdentifier: "InfoSegue", sender: self)
        
    }
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwindSegueInfoVC(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
//        read_json()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllThings()
        tableView.reloadData()
    }
    
    func read_json() {
        do {
            if let file = Bundle.main.url(forResource: "data", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? NSDictionary {
                    for (key,val) in object {
                        if let name = key as? String {
                            let newBreed = Breed(context: context)
                            newBreed.name = name
                            if let content = val as? NSDictionary {
                                if let origin = content["origin"] as?  NSArray {
                                    if let theorigin = origin[0] as? String {
                                        newBreed.origin = theorigin
                                        print(newBreed.origin)
                                    }
                                }
                                if let size = content["size"] as? NSArray {
                                    if let thesize = size[0] as? String {
                                        newBreed.size = thesize
                                        print(newBreed.size)
                                    }
                                  
                                }
                                if let life_span = content["life_span"] as? NSArray {
                                    if let thelife_span = life_span[0] as? Double {
                                        newBreed.life_span = thelife_span
                                    }
                                    print(newBreed.life_span)
                                    
                                }
                                if let temperament = content["temperament"] as? [String] {
                                    var onestring = ""
                                    for i in temperament {
                                        onestring = onestring + i
                                    }
                                    newBreed.temperament = onestring
                                    print(newBreed.temperament)
                                }
                                    
                                if let female_weight = content["female weight"] as? NSArray {
                                    if let the_fem_weight = female_weight[0] as? Double {
                                        newBreed.female_weight = the_fem_weight
                                    }
                                    print(newBreed.female_weight)
                                }
                                if let male_weight = content["male weight"] as? NSArray {
                                    if let the_male_weight = male_weight[0] as? Double {
                                        newBreed.male_weight = the_male_weight
                                    }
                                    
                                }
                                if let female_height = content["female weight"] as? NSArray {
                                    if let the_female_height = female_height[0] as? Double {
                                        newBreed.female_weight = the_female_height
                                    }
                                   
                                }
                                if let male_height = content["male weight"] as? NSArray {
                                    if let the_male_height = male_height[0] as? Double {
                                        newBreed.male_height = the_male_height
                                    }
                                    
                                }
                                if let litter_size = content["litter size"] as? NSArray {
                                    if let the_litter_size = litter_size[0] as? Double {
                                        newBreed.litter_size = the_litter_size
                                    }
                                    
                                }
                                if let shedding = content["shedding"] as? NSArray {
                                    if let theshedding = shedding[0] as? String {
                                        newBreed.shedding = theshedding
                                    }
                                }
                                if let hair_length = content["hair length"] as? NSArray {
                                    if let thehair_length = hair_length[0] as? Double {
                                        newBreed.hair_length = thehair_length
                                    }
                                }
                            }
                        tableData.append(newBreed)
                        appDelegate.saveContext()
                        }
                    }
                    
                } else if let object = json as? [Any] {
                    // json is an array
                    print("array", object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
        print("done")
    }
    
    func fetchAllThings(){
        let breedRequest:NSFetchRequest<Breed> = Breed.fetchRequest()
        
//        let pred = NSPredicate(format: "name")
        
        do {
            tableData = try context.fetch(breedRequest)
            print("this is table Data", tableData)
            // Here we can store the fetched data in an array
        } catch {
            print(error)
        }
    }
}
    
extension InfoVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath)
        let content = tableData[indexPath.row]
        cell.textLabel?.text = content.name
        cell.detailTextLabel?.text = "herro"
        return cell
    }
}
