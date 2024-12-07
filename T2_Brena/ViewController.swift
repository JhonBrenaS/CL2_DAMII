import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tvSupervisores: UITableView!
    
    @IBOutlet weak var txtSueldo: UITextField!
    
    
    @IBOutlet weak var btnFiltrar: UIButton! 
    
    var lista: [SupervisorEntity] = [] 
    var listaFiltrada: [SupervisorEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Cargar los supervisores inicialmente
        lista = ControladorSupervisor().findAll()
        listaFiltrada = lista
        
        // Configuración de la tabla
        tvSupervisores.dataSource = self
        tvSupervisores.delegate = self
        tvSupervisores.rowHeight = 200
        tvSupervisores.reloadData()
    }
    
    // Acción del botón Filtrar
    @IBAction func btnFiltrar(_ sender: Any) {
        // Verifica si el valor ingresado es válido
        guard let sueldoText = txtSueldo.text, let sueldo = Double(sueldoText), sueldo >= 0 else {
            let alert = UIAlertController(title: "Error", message: "Por favor, ingrese un sueldo válido.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
            return
        }
        
        listaFiltrada = lista.filter { $0.sueldo >= sueldo }
        
        tvSupervisores.reloadData()
    }
    
    // MARK: - Métodos del DataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listaFiltrada.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Obtener la celda reutilizable
        let row = tvSupervisores.dequeueReusableCell(withIdentifier: "celda") as! ItemTableViewCell
        
        // Obtener el supervisor de la lista filtrada
        let supervisor = listaFiltrada[indexPath.row]
        row.lblNombre.text = supervisor.nombre
        row.lblApellido.text = supervisor.apellido
        
        return row
    }
    
    // MARK: - Métodos del Delegate (si es necesario)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Realizar acción cuando se selecciona una fila (por ejemplo, navegar a otra vista)
        performSegue(withIdentifier: "datos", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "datos" {
            let pantalla2 = segue.destination as! DatosSupervisorViewController
            pantalla2.obj = listaFiltrada[tvSupervisores.indexPathForSelectedRow!.row]
        }
    }
    
    // Acción para el botón Nuevo
    @IBAction func btnNuevo(_ sender: Any) {
        performSegue(withIdentifier: "nuevo", sender: nil)
    }
}
