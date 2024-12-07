//
//  ControladorSupervisor.swift
//  T2_Brena
//
//  Created by DAMII on 3/12/24.
//

import UIKit
import CoreData

class ControladorSupervisor:PMetodos{
    
    func save(bean: Supervisor) -> Int {
            var salida = -1
            //1. crear objeto de la clase AppDelegate
            let delegate=UIApplication.shared.delegate as! AppDelegate
            //2. acceder a la variable persistentContainer "conexion con la BD"
            let contextoBD=delegate.persistentContainer.viewContext
            //3. acceder a la entidad
            let tabla=SupervisorEntity(context: contextoBD)
            //4. setear los atributos del parametro bean a la "tabla"
            tabla.codigo=Int16(bean.codigo)
            tabla.nombre=bean.nombre
            tabla.apellido=bean.apellido
            tabla.sueldo=bean.sueldo
            //5. controlar exception
            do{
                //6. grabar
                try contextoBD.save()
                salida=1
            }catch let ex as NSError{
                print(ex.localizedDescription)
            }
            return salida
        }
        func findAll() -> [SupervisorEntity] {
            //declarar
            var datos:[SupervisorEntity]!
            //1. crear objeto de la clase AppDelegate
            let delegate=UIApplication.shared.delegate as! AppDelegate
            //2. acceder a la variable persistentContainer "conexion con la BD"
            let contextoBD=delegate.persistentContainer.viewContext
            //3. obtener contenido de la entidad "ClienteEntity"
            let registros=SupervisorEntity.fetchRequest()
            //4. controlar exception
            do{
                //5. recorrido sobre "registros" y guardar la informacion
                //dentro de datos
                try datos=contextoBD.fetch(registros)
            }catch let ex as NSError{
                print(ex.localizedDescription)
            }
            return datos
        }
    
    func findByCodigo(codigo: Int) -> SupervisorEntity? {
        //1. Create an instance of AppDelegate
        let delegate = UIApplication.shared.delegate as! AppDelegate
        //2. Access the persistentContainer
        let contextoBD = delegate.persistentContainer.viewContext
        //3. Prepare the fetch request
        let fetchRequest: NSFetchRequest<SupervisorEntity> = SupervisorEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "codigo == %d", codigo)
        //4. Attempt to fetch the result
        do {
            let resultados = try contextoBD.fetch(fetchRequest)
            return resultados.first // Return the first match if it exists
        } catch let ex as NSError {
            print("Error: \(ex.localizedDescription)")
            return nil
        }
    }
}
