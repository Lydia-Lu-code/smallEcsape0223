//
//  ResOkTableViewController.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/2/23.
//

import UIKit

class ResTableViewController: UITableViewController {

    var resDatas = [UpdataResData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshControl = UIRefreshControl()
        refreshControl!.addTarget(self, action: #selector(getData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

        @objc func getData(){
            resDatas.removeAll()

        if let url = URL(string: UrlRequestTask.shared.spreadSheetResLink) {
            URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            if error == nil && data != nil{
                let decoder = JSONDecoder()
                do{
                    let downloadData = try decoder.decode(DownloadData.self, from: data!)
                    let resDatas = downloadData.feed.entry
                    
                    for i in 0..<resDatas.count {
                    let topic = resDatas[i].res_topic.text
                    let date = resDatas[i].res_date.text
                    let time = resDatas[i].res_time.text
                    let name = resDatas[i].res_name.text
                    let people = resDatas[i].res_people.text
                    let tel = resDatas[i].res_tel.text
                    
                    let resData = UpdataResData(res_topic: topic, res_date: date, res_time: time, res_name: name, res_people: people, res_tel: tel)
                        
                    self.resDatas.append(resData)
                }
                    DispatchQueue.main.async {
                        self.refreshControl!.endRefreshing()
                        self.tableView.reloadData()
                    }
                }catch{
                    print(error)
                    }
                }
            }.resume()
        }
    }
    
    func deleteData(with resContent: ResContent, completionHandler: @escaping (Bool) -> Void) {
        
        let urlLink = "\(UrlRequestTask.shared.sheetDBResPatch)/res_name/\(resContent.res_name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            //因為有可能欄位的值是中文字，字串要先用addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)處理過
            if let urlString = urlLink!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString){
                var request = URLRequest(url: url)
                request.httpMethod = "DELETE"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                URLSession.shared.dataTask(with: request) { (returnData, response, error) in
                    if error != nil {
                        print("error = \(error?.localizedDescription)")
                    }
                    let decoder = JSONDecoder()
                    if let returnData = returnData, let dictionary = try? decoder.decode([String: Int].self, from: returnData), dictionary["deleted"] != nil{
                        print("Delete successfully")
                        completionHandler(true)
                    }else{
                        print("Delete failed")
                        completionHandler(false)
                    }
                }.resume()
            }
        }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resDatas.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let showRes = resDatas[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "resCell", for: indexPath) as? ResTableViewCell

        cell?.topicLabel.text = "\(showRes.res_topic)"
        cell?.dataLabel.text = "\(showRes.res_date)"
        cell?.nameLabel.text = "\(showRes.res_name)"
        cell?.peopleLabel.text = "\(showRes.res_people)"
        cell?.phoneLabel.text = "\(showRes.res_tel)"

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .default, title: "刪除") { [self]
                action, index in
                
            var deletedItem = resDatas[indexPath.row].res_name
            let url = URL(string: "\(UrlRequestTask.shared.sheetDBResPatch)/res_name/\(deletedItem)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data ,let confirmDeleteData = try? JSONDecoder().decode([String:Int].self, from: data) , confirmDeleteData["deleted"]==1{
                    print("Deleted Item")
                }else{
                    print("Failed")
                }
                
            }.resume()
                self.resDatas.remove(at: index.row)
                self.tableView.reloadData()
            }
            return [deleteAction]
        }
    
    //傳輸資料
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "AddSegue" else {
        if let controller = segue.destination as? ReviseVController,
           let row = tableView.indexPathForSelectedRow?.row {
            controller.updataResDates = [resDatas[row]]
            }
            return
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
