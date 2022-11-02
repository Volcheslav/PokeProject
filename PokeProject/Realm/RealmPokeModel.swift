//
//  RealmPokeModel.swift
//  PokeProject
//
//  Created by User on 2.11.22.
//

import Foundation
import RealmSwift

class RealmPokeModel: Object {
    
    @Persisted var name: String = ""
    @Persisted var height: String = ""
    @Persisted var id: String = ""
    @Persisted var sprites: String = ""
    @Persisted var types: String = ""
    @Persisted var weight: String = ""
}
