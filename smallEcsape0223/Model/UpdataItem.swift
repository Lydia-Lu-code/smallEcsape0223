//
//  InitEscapeData.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/2/23.
//

import Foundation

//struct UpdataItem: Codable{
//    var data: [UpdataResData]
//}
struct UpdataItem: Codable{
    var data: UpdataResData
}

struct UpdataResData: Codable{
    var res_topic: String
    var res_date: String
    var res_time: String
    var res_name: String
    var res_people: String
    var res_tel: String
}
  
//    static func == (lhs: InitResData, rhs: InitResData) -> Bool {
//        if lhs.res_topic == rhs.res_topic &&
//            lhs.res_date == rhs.res_date  &&
//            lhs.res_name == rhs.res_name &&
//            lhs.res_people == rhs.res_people &&
//            lhs.res_tel == rhs.res_tel {
//            return true
//        }else {
//            return false
//        }
//   }



