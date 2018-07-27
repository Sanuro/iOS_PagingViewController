

import UIKit
import CoreData

class InfoVC: UIViewController{
    var tableData: [Breed] = []
    var dogBreedName = " "
    var display_these_props = ["Name:", "Origin:", "Size:", "Life span:", "Height:", "Weight:", "Shedding", "Litter size", "Hair length", "Temperament:"]
    
    @IBOutlet var breedInfoTable: [UILabel]!
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    @IBOutlet weak var tableView: UITableView!
    
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
        print("went here")
//        fetchAllThings()
//        read_json()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchAllThings()
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
        print("went into fetch")
        let breedRequest:NSFetchRequest<Breed> = Breed.fetchRequest()
        print(dogBreedName)
//        let format = "name = " + dogBreedName
        let pred = NSPredicate(format: "name == %@", dogBreedName.lowercased())
        breedRequest.predicate = pred
        do {
            tableData = try context.fetch(breedRequest)
            print("This is table data", tableData)
            if tableData.count >= 1{
                breedInfoTable[0].text = tableData[0].name
                breedInfoTable[1].text = tableData[0].origin
                breedInfoTable[2].text = String(tableData[0].life_span)
                breedInfoTable[3].text = tableData[0].size
                breedInfoTable[4].text = String(tableData[0].male_weight)
                breedInfoTable[5].text = String(tableData[0].female_weight)
                breedInfoTable[6].text = String(tableData[0].male_height)
                breedInfoTable[7].text = String(tableData[0].female_height)
                breedInfoTable[8].text = tableData[0].temperament
                breedInfoTable[9].text = tableData[0].shedding
                breedInfoTable[10].text = String(tableData[0].litter_size)
                breedInfoTable[11].text = String(tableData[0].hair_length)
            }
            
            


            print("this is table Data", tableData)
            // Here we can store the fetched data in an array
        } catch {
            print(error)
        }
    }
}
    
//extension InfoVC: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return display_these_props.count
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if display_these_props[section] == "height" ||
//            display_these_props[section]  == "weight" {
//            return 2
//        }
//        else if display_these_props[section] == "temperament" {
//            return 5
//        }
//        return 1
//    }
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CellOne", for: indexPath)
//        let content = tableData[0]
//        cell.textLabel?.text = content.name
//        cell.detailTextLabel?.text = "herro"
//        return cell
//    }
//}
