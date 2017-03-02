//
//  JsonHandler.swift
//  MovieSearchApp
//
//  Created by Glizela Taino on 3/2/17.
//  Copyright © 2017 Glizela Taino. All rights reserved.
//

import UIKit

struct JsonHandler {
    static func getJSON(path: String) -> JSON{
        guard let url = URL(string: path)else { return JSON.null }
        do {
            let data = try Data(contentsOf: url)
            return JSON(data: data)
        } catch {
            return JSON.null
        }
    }
}
