//
//  PMetodos.swift
//  T2_Brena
//
//  Created by DAMII on 3/12/24.
//

import UIKit

protocol PMetodos {
    func save(bean:Supervisor)->Int
    func findAll()->[SupervisorEntity]
    func findByCodigo(codigo: Int) -> SupervisorEntity?
}
