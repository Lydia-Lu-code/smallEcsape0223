//
//  ReviseVController.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/3/8.
//

import UIKit

class ReviseVController: UIViewController {

    @IBOutlet weak var name_Rev: UITextField!
    @IBOutlet var phone_Rev: UITextField!
    @IBOutlet var people_Rev: UILabel!
    @IBOutlet weak var btn_Rev: UIButton!
    @IBOutlet weak var meg_Rev: UITextView!
    @IBOutlet var topicBtn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var subBtn: UIButton!
    @IBOutlet var addBtn: UIButton!
    @IBOutlet var colorLabel: [UILabel]!
    
    var updataResDates: [UpdataResData]?
    var dateSelect: String = ""
    var timeSelect: String = ""
    var topicName: String = ""
    var timer : Timer?
    var i :Int = 0
    var stratSpeed: Int = 0
    var time1: String = ""
    var time2: String = ""
    var rev_name = ""
    
    var urlLink = ""
    var httpMethodStr: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //精簡模式
        datePicker.preferredDatePickerStyle = .compact
        datePicker.minimumDate = Date()
        anime()
       
        guard updataResDates == nil else {
            
            topicBtn.setTitle("\(updataResDates![0].res_topic)", for: .normal)
            datePicker.setDate(string2Date("\(updataResDates![0].res_date) \(updataResDates![0].res_time)", dateFormat: "yyyy/MM/dd HH:mm"), animated: true)
            name_Rev.text = updataResDates![0].res_name
            rev_name = name_Rev.text!
            phone_Rev.text = "0\(updataResDates![0].res_tel)"
            people_Rev.text = updataResDates![0].res_people
            meg_Rev.text = ""
            settingData(topicEscape: "\(String(describing: topicBtn.title(for: .normal)))")
            topicName = topicBtn.currentTitle!
            return
        }
    }
    
    @IBAction func updateBtn(_ sender: Any) {
        
        let resTopic = topicBtn.title(for: .normal)
        let resDate = dateSelect
        let resTime = timeSelect
        let resPeople = people_Rev.text!
        let resName = name_Rev.text!
        let resTel = phone_Rev.text!
        
        let newUpdata = UpdataResData(res_topic: resTopic!, res_date: resDate, res_time: resTime, res_name: resName, res_people: resPeople, res_tel: resTel)

        updata(with: newUpdata)
    }
    
    @IBAction func selectBtn(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Updata", message: "請選擇密室主題。", preferredStyle: .actionSheet)
        
        for escape in topicEscape{
            let okAction = UIAlertAction(title: escape, style: .default) { [self] (_) in
            sender.setTitle("\(escape)", for: .normal)
                topicName = "\(sender.title(for: .selected)!)"
                settingData(topicEscape: topicName)
                people_Rev.text = "\(range[0])"

                }
            alertController.addAction(okAction)
        }
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)

        alertController.addAction(cancelAction)
        present(alertController, animated: true)
        
    }

    @IBAction func selectPicker(_ sender: UIDatePicker) {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        dateSelect = formatter.string(from: datePicker.date)
        
        let formatter1 = DateFormatter()
        formatter1.dateFormat = "HH:mm"
        timeSelect = formatter1.string(from: datePicker.date)
    }
    
    @IBAction func sub(_ sender: Any) {
        settingData(topicEscape: topicName)
//        print("**settingData(topicEscape: topicName) == \(settingData(topicEscape: topicName))")
        guard Int(people_Rev.text!)! > range[0] else {
            print("**add error")
            return
        }
            people_Rev.text = String(Int(people_Rev.text!)! - 1)
    }
    
    @IBAction func add(_ sender: Any) {
        settingData(topicEscape: topicName)

        guard Int(people_Rev.text!)! < range[1] else {
            print("**add error")
            return
        }
            people_Rev.text = String(Int(people_Rev.text!)! + 1)
    }
    
    func string2Date(_ string:String, dateFormat:String = "yyyy/MM/dd HH:mm") -> Date {
        let formatter = DateFormatter()
        formatter.locale = Locale.init(identifier: "zh_TW")
        formatter.dateFormat = dateFormat
        let date = formatter.date(from: string)
        return date!
    }

        func updata(with newInit: UpdataResData) {
            
            if newInit.res_name == rev_name{
                urlLink = "\(UrlRequestTask.shared.sheetDBResPatch)/res_name/\(name_Rev.text!)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                httpMethodStr = "PATCH"
            }else{
            urlLink = "\(UrlRequestTask.shared.sheetDBResPatch)"
            httpMethodStr = "POST"
            }

            var request = URLRequest(url: (URL(string: urlLink)!))
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpMethod = httpMethodStr
            
            let newUpdataItem = UpdataItem(data: newInit)
            if let updataItem = try? JSONEncoder().encode(newUpdataItem){
                URLSession.shared.uploadTask(with: request, from: updataItem) { (data, response, error) in
                    if let data = data, let passResult = try? JSONDecoder().decode([String:Int].self, from: data),passResult["updated"] == 1{
                        print("**data == \(data)")
                    }else{
                        print("**error")
                    }
                }.resume()
            }
        }
    
    func anime(){
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [self] (_) in
            i = i + 1
            guard i == 16 else{
                let speed = i * 30
            
            for x in 0...3{
                stratSpeed = x * 20
                colorLabel[x].frame.origin.x = CGFloat((-280 - stratSpeed) + speed)
                colorLabel[x].alpha = 0.8
                colorLabel[x].layer.cornerRadius = 20
                colorLabel[x].layer.masksToBounds = true
            }
                return
            }
            timer?.invalidate()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if timer != nil {
            timer?.invalidate()
        }
    }
}
