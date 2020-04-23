//
//  CovidRecord.swift
//  Covid
//
//  Created by Foltányi Kolos on 2020. 03. 30..
//  Copyright © 2020. Foltányi Kolos. All rights reserved.
//

import Foundation

struct CovidRecord {
    var keyId: String
    var country: String
    var province: String?
    var city: String?
    var confirmed: Int
    var recovered: Int
    var deaths: Int
    var lastUpdate: Date
}

extension CovidRecord: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        keyId = try container.decode(String.self, forKey: .keyId)
        country = try container.decode(String.self, forKey: .country)
        province = try container.decodeIfPresent(String.self, forKey: .province)
        city = try container.decodeIfPresent(String.self, forKey: .city)
        confirmed = try container.decode(Int.self, forKey: .confirmed)
        recovered = try container.decodeIfPresent(Int.self, forKey: .recovered) ?? 0
        deaths = try container.decode(Int.self, forKey: .deaths)
        let lastUpdateStr = try container.decode(String.self, forKey: .lastUpdate)
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        guard let lastUpdateDate = formatter.date(from: lastUpdateStr) else {
            throw DecodingError.dataCorruptedError(
                forKey: .lastUpdate,
                in: container,
                debugDescription: "Wrong date format"
            )
        }
        lastUpdate = lastUpdateDate
    }
}
