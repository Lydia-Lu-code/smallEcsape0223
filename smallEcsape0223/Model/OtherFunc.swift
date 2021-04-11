//
//  otherFunc.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/3/31.
//

import Foundation

var topicEscape = ["莎士比亞的邀請","時鐘之國","鄉間小盜","禁錮之村","流亡黯道"]
//
//struct initData {
//    var timeArr: [String]?
//    var range: [Int]?
//
//init(timeArr: [String]? = nil, range: [Int]? = nil) {
//        self.timeArr = timeArr
//        self.range = range
//    }
//}


var timeArr = [String]()
var range = [Int]()

func settingData(topicEscape: String) {
    
//    guard topicEscape == "請選擇" else {
        switch topicEscape {
        case "莎士比亞的邀請":
            timeArr = ["10:15","11:45","13:15","14:45","16:15","17:45","19:15","20:45"]
            range = [2,6]
//            initData.init(timeArr: timeArr, range: {range})

        case "時鐘之國":
            timeArr = ["09:30","11:00","12:30","13:30","15:00","16:30","17:30","19:00","20:30"]
            range = [2,4]

        case "鄉間小盜":
            timeArr = ["10:30","11:30","12:30","13:30","14:30","15:30","16:30","17:30","18:30","19:30","20:30"]
            range = [2,4]

        case "禁錮之村":
            timeArr = ["11:00","13:00","15:00","17:00","19:00","21:00"]
            range = [5,10]

        case "流亡黯道":
            timeArr = ["11:00","13:00","15:00","17:00","19:00","21:00"]
            range = [4,8]

        default: break
                }
//        return initData.init(timeArr: timeArr, range: range)
//        }
    

//    initData
    }

