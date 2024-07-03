//
//  DataModel.swift
//  practiceView
//
//  Created by KKNANXX on 7/2/24.
//

import Foundation

struct LocationData: Codable, Identifiable {
    let city: String
    let country: String
    let patientID: String
    
    var id: String { patientID }
    
    enum CodingKeys: String, CodingKey {
        case city
        case country
        case patientID = "patient_id"
    }
}
