//
//  MainRealmModel.swift
//  PokeProject
//
//  Created by User on 1.11.22.

import Foundation
import RealmSwift

class MainRealmModel: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var url: String = ""
}
