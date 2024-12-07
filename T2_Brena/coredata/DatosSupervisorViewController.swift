//
//  DatosSupervisorViewController.swift
//  T2_Brena
//
//  Created by DAMII on 3/12/24.
//

import UIKit

class DatosSupervisorViewController: UIViewController {
    
    @IBOutlet weak var lblCodigo: UILabel!
    
    @IBOutlet weak var lblNombre: UILabel!
    
    @IBOutlet weak var lblApellidos: UILabel!
    
    @IBOutlet weak var lblSueldo: UILabel!
    
    var obj:SupervisorEntity!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCodigo.text=String(obj.codigo)
        lblNombre.text=obj.nombre
        lblApellidos.text=obj.apellido
        lblSueldo.text=String(obj.sueldo)
    }

    
    @IBAction func btnVolver(_ sender: Any) {
        performSegue(withIdentifier: "volver2", sender: nil)
    }
    
    func getCodigo()->Int{
            return Int(lblCodigo.text ?? "") ?? 0
        }
    func getNombre()->String{
           return lblNombre.text ?? ""
       }
       func getApellido()->String{
           return lblApellidos.text ?? ""
       }
       func getSueldo()->Double{
           return Double(lblSueldo.text ?? "0") ?? 0
       }
       //funcion para crear ventana de mensaje
       func getVentana(_ msg:String){
           //crear ventana
           let ventana=UIAlertController(title: "Sistema", message: msg, preferredStyle: .alert)
           //crear boton
           ventana.addAction(UIAlertAction(title: "Aceptar", style: .default))
           //mostrar ventana
           present(ventana, animated: true)
       }
}
