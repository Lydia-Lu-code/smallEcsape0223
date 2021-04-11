//
//  GoogleSheetUpload.swift
//  smallEcsape0223
//
//  Created by 維衣 on 2021/2/23.
//

import Foundation

struct DownloadData: Codable {
    var feed: SheetFeed
}

struct SheetFeed: Codable {
    var entry: [ResContent]
}

struct ResContent: Codable {
    var res_topic: ResText
    var res_date: ResText
    var res_time: ResText
    var res_people: ResText
    var res_name: ResText
    var res_tel: ResText

    enum CodingKeys: String, CodingKey {
    
        case res_topic = "gsx$restopic"
        case res_date = "gsx$resdate"
        case res_time = "gsx$restime"
        case res_people = "gsx$respeople"
        case res_name = "gsx$resname"
        case res_tel = "gsx$restel"
    }
}

struct ResText: Codable {
    var text: String
    enum CodingKeys: String, CodingKey {
        case text = "$t"
    }
}

