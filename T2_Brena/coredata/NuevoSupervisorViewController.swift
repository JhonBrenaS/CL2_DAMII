//
//  NuevoSupervisorViewController.swift
//  T2_Brena
//
//  Created by DAMII on 3/12/24.
//

import UIKit

class NuevoSupervisorViewController: UIViewController {

    
    @IBOutlet weak var txtCodigo: UITextField!
    
    @IBOutlet weak var txtNombre: UITextField!
    
    @IBOutlet weak var txtApellido: UITextField!
    
    
    @IBOutlet weak var txtSueldo: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnGrabar(_ sender: Any) {
        let cod = getCodigo()
        let nom = getNombre()
        let ape = getApellido()
        let cred = getSueldo()
        
        // Validate input fields
        if cod == 0 {
            getVentana("Por favor, ingrese un código válido.")
            return
        }
        if nom.isEmpty {
            getVentana("Por favor, ingrese un nombre.")
            return
        }
        if ape.isEmpty {
            getVentana("Por favor, ingrese un apellido.")
            return
        }
        if cred <= 0 {
            getVentana("Por favor, ingrese un sueldo válido.")
            return
        }
        
        // Check if the code already exists
        let controlador = ControladorSupervisor()
        if let _ = controlador.findByCodigo(codigo: cod) {
            getVentana("El código ingresado ya existe. Intente con otro.")
            return
        }
        
        // Save the new supervisor
        let obj = Supervisor(codigo: cod, nombre: nom, apellido: ape, sueldo: cred)
        let estado = controlador.save(bean: obj)
        if estado > 0 {
            // Show confirmation message
            let ventana = UIAlertController(title: "Sistema", message: "Supervisor registrado correctamente.", preferredStyle: .alert)
            ventana.addAction(UIAlertAction(title: "Aceptar", style: .default) { _ in
                self.performSegue(withIdentifier: "volver1", sender: nil) // Redirect after confirmation
            })
            present(ventana, animated: true)
        } else {
            getVentana("Error al registrar el supervisor.")
        }
    }

    
    @IBAction func btnVolver(_ sender: Any) {
        performSegue(withIdentifier: "volver1", sender: nil)

    }
    
    
    
    func getCodigo()->Int{
            return Int(txtCodigo.text ?? "0") ?? 0
        }
        func getNombre()->String{
            return txtNombre.text ?? ""
        }
        func getApellido()->String{
            return txtApellido.text ?? ""
        }
        func getSueldo()->Double{
            return Double(txtSueldo.text ?? "0") ?? 0
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
