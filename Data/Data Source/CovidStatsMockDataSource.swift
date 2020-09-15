//
//  CovidStatsMockDataSource.swift
//  Covid
//
//  Created by Foltányi Kolos on 2020. 04. 04..
//  Copyright © 2020. Foltányi Kolos. All rights reserved.
//

import Foundation

class CovidStatsMockDataSource: CovidStatsDataSource {
    func getCovidData(completion: @escaping (CovidStats?, Error?) -> Void) {
        let data = mockResponse.data(using: .utf8)
        let decoder = JSONDecoder()
        let response = try? decoder.decode(CovidStatsResponse.self, from: data!)
        completion(response?.data, nil)
    }
    
    func getCovidData(for country: Country, completion: @escaping (CovidStats?, Error?) -> Void) {
        getCovidData() { stats, _ in
            guard let stats = stats else { return }
            var response = stats
            response.records = stats.records.filter { $0.country == country.name }
            completion(response, nil)
        }
    }
    
    var mockResponse = """
        {
            "statusCode": 200,
            "message": "OK",
            "error": false,
            "data": {
                "covid19Stats": [
                    {"country":"Netherlands","deaths":0,"city":"","keyId":"Aruba, Netherlands","confirmed":62,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":1,"province":"Aruba"},
                    {"country":"Netherlands","deaths":1,"city":"","keyId":"Curacao, Netherlands","confirmed":11,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":3,"province":"Curacao"},
                    {"country":"Netherlands","deaths":2,"city":"","keyId":"Sint Maarten, Netherlands","confirmed":23,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":6,"province":"Sint Maarten"},
                    {"country":"Belgium","deaths":1143,"city":"","keyId":"Belgium","confirmed":16770,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":2872,"province":""},
                    {"country":"Germany","deaths":1275,"city":"","keyId":"Germany","confirmed":91159,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":24575,"province":""},
                    {"country":"Hungary","deaths":26,"city":"","keyId":"Hungary","confirmed":623,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":43,"province":""},
                    {"country":"Iran","deaths":3294,"city":"","keyId":"Iran","confirmed":53183,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":17935,"province":""},
                    {"country":"Italy","deaths":14681,"city":"","keyId":"Italy","confirmed":119827,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":19758,"province":""},
                    {"country":"Korea, South","deaths":174,"city":"","keyId":"Korea, South","confirmed":10062,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":6021,"province":""},
                    {"country":"Netherlands","deaths":1487,"city":"","keyId":"Netherlands","confirmed":15723,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":250,"province":""},
                    {"country":"New Zealand","deaths":1,"city":"","keyId":"New Zealand","confirmed":868,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":103,"province":""},
                    {"country":"Poland","deaths":71,"city":"","keyId":"Poland","confirmed":3383,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":56,"province":""},
                    {"country":"Russia","deaths":34,"city":"","keyId":"Russia","confirmed":4149,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":281,"province":""},
                    {"country":"South Africa","deaths":9,"city":"","keyId":"South Africa","confirmed":1505,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":95,"province":""},
                    {"country":"Spain","deaths":11198,"city":"","keyId":"Spain","confirmed":119199,"lastUpdate":"2020-09-15T09:00:26+0000","recovered":30513,"province":""}
                ],
                "lastChecked":"20-04-04T11:06:19.307+0000"
            }
        }
    """
}
