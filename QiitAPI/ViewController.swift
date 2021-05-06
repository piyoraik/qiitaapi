import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadNow: UIActivityIndicatorView!

    
    
    @IBAction func test(_ sender: UIButton) {
        self.tableView.reloadData()
    }
    
    // 記事格納の為の、Dictionary型変数宣言
    var articles : [[String : String?]] = []
    
    // URL格納変数
    var selectURL :String!
    // タイトル格納変数
    var selectTitle :String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //API通信でとってきたものをViewに表示
        getArticles()
    }
    //TableViewに表示させるもの
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    //TableViewの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        var article = articles[indexPath.row]
        cell.textLabel?.text = article["title"]!
        cell.detailTextLabel?.text = article["userId"]!
        return cell
    }
    
    // セルがタップされたとき
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var newArticle = articles[indexPath.row]
        selectURL = newArticle["url"]!
        selectTitle = newArticle["title"]!
        performSegue(withIdentifier: "toNewViewController", sender: nil)
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    // 値引き渡し
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toNewViewController" {
            let nextView = segue.destination as! NewViewController
            nextView.testString = selectURL!
        }
    }
    // API通信 
    func getArticles() {
        loadNow.startAnimating()
        let _ = AF.request("https://qiita.com/api/v2/items")
                .responseJSON { reponse in
                    guard let object = reponse.data else {
                        return
                    }

                    var json = JSON(object)
                    //print(json)
                    json.forEach { (_, json) in
                        var article: [String: String?] = [
                        "title": json["title"].string,
                        "url": json["url"].string,
                        "userId": json["user"]["id"].string,
                        ]
                        self.articles.append(article)
                
                    }
                    self.loadNow.stopAnimating()
                    self.tableView.reloadData()
                    
        }
    }
    
}
