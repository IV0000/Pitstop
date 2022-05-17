
import Foundation
import CoreData

class DataViewModel : ObservableObject {
    
    let manager = CoreDataManager.instance

    // Vehicle
//    @Published var vehicleModel = VehicleModel(vehicle: <#Vehicle#>)
    @Published var vehicleList : [VehicleViewModel] = []   //Var to store all the fetched vehicle entities
    @Published var currVehicle = Vehicle() /// da togliere
    
    @Published var currentVehicle : [Vehicle] = []
    
    //Expense
    @Published var expenses : [Expense] = []
    @Published var expenseModel = ExpenseModel()
    
    //Filter
    @Published var filter : NSPredicate?
    
    init() {
        getVehicles()
//        getExpenses(filter: filter)
    }
    
    func getVehicleID(id : UUID){
        let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        let filter = NSPredicate(format: "vehicleID == %@", id as CVarArg)
        request.predicate = filter
        
        do {
             currentVehicle =  try manager.context.fetch(request)
        }catch let error {
            print("🚓 Error fetching the vehicle ID: \(error.localizedDescription)")
        }
        
    }
    
//    func getCurrentVehicle() {
//        let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
//
//        let filter = NSPredicate(format: "current == %@", "true")
//        request.predicate = filter
//
//        do {
//            vehicles =  try manager.context.fetch(request)
//        }catch let error {
//            print("🚓 Error fetching current vehicle: \(error.localizedDescription)")
//        }
//    }
    
    //MARK: VEHICLE FUNCTIONS
    func getVehicles() {
        
        let request = NSFetchRequest<Vehicle>(entityName: "Vehicle")
        let vehicle : [Vehicle]
        
        //Sort for ID
        let sort = NSSortDescriptor(keyPath: \Vehicle.objectID, ascending: true)
        request.sortDescriptors = [sort]
        
        //Filter if needed, ad esempio qua filtro per veicoli a benzina
//        let filter = NSPredicate(format: "fuelType == %@", "1")
    
        do {
            vehicle =  try manager.context.fetch(request)
            DispatchQueue.main.async{
                self.vehicleList = vehicle.map(VehicleViewModel.init)
            }
        }catch let error {
            print("🚓 Error fetching vehicles: \(error.localizedDescription)")
        }
        
        
    }
    
    func addVehicle(vehicle : VehicleState) {
        let newVehicle = Vehicle(context: manager.context)
        newVehicle.name = vehicle.name
        newVehicle.brand = vehicle.brand
        newVehicle.model = vehicle.model
//        print(newVehicle)
        saveVehicle()
        
    }
    
 
    //In case we need it
    func removeAllVehicles() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Vehicle")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        manager.removeAllItems(deleteRequest: deleteRequest)
        getVehicles()
    }
    
//    func removeVehicle(indexSet: IndexSet) {
//        guard let index = indexSet.first else { return }
//        let entity = vehicleList[index]
//        manager.container.viewContext.delete(entity)
//        saveVehicle()
//    }
    
    func removeVehicle(vehicle : VehicleViewModel) {
        let vehicle = manager.getVehicleId(id: vehicle.vehicleID)
        if let vehicle = vehicle {
            manager.deleteVehicle(vehicle)
        }
        saveVehicle()
    }
    
    func setCurrentVehicle(currVehicle: Vehicle) {
        self.currVehicle = currVehicle
        print(self.currVehicle.name ?? "")
    }
    
    //MARK: TODOOOOO
//    func updateVehicle(entity: Vehicle, vehicleUpdate: VehicleViewModel) {
//        entity.name = vehicleUpdate.name
//        saveVehicle()
//    }
    
    func updateCurrentVehicle(vehicleUpdate: VehicleViewModel) {
       
//        getVehicleID(id: vehicleUpdate.vehicleID ?? UUID())
//        currentVehicle.first?.current = true
//        //UPDATE ENTITA SU CORE DATA ???????
//        saveVehicle()
    }
    
    func updateVehicle(_ vs : VehicleState) throws{
        
        guard let vehicleID = vs.vehicleID else {
            return print("Vehicle not found")
        }
        
        guard let vehicle = manager.getVehicleId(id: vehicleID) else {
            return print("Vehicle not found")
        }
        
        vehicle.name = vs.name
        vehicle.brand = vs.brand
        // etc etc
        
        manager.save()
    }
    
    func getVehicleId(vehicleId : NSManagedObjectID) throws -> VehicleViewModel {
        guard let vehicle = manager.getVehicleId(id: vehicleId) else {
           throw fatalError() // DA FIXARE
        }
        
        let vehicleVM = VehicleViewModel(vehicle: vehicle)
        return vehicleVM
    }
    
    
    func saveVehicle() {
        manager.save()
        getVehicles()
    }
    
    
    
    //MARK: EXPENSE FUNCTIONS
    func getExpenses(filter : NSPredicate?){
        
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.predicate = filter
        
        do {
            expenses =  try manager.context.fetch(request)
        }catch let error {
            print("💰 Error fetching expenses: \(error.localizedDescription)")
        }
    }
    
    func addExpense(expense : ExpenseModel) {
        let newExpense = Expense(context: manager.context)
        newExpense.vehicle = currVehicle
        print(" Expense : \(expense)")
        saveExpense()
    }
    
    func removeExpense(indexSet: IndexSet) {

        guard let index = indexSet.first else { return }
        let entity = expenses[index]
        manager.container.viewContext.delete(entity)
        saveExpense()
    }
    
    func removeAllExpenses() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Expense")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        manager.removeAllItems(deleteRequest: deleteRequest)
        getExpenses(filter: filter)
    }
    
    func saveExpense() {
        manager.save()
        getExpenses(filter: filter)
    }
    
}


struct VehicleViewModel : Hashable {
    
    let vehicle : Vehicle
    
    var brand : String {
        return vehicle.brand ?? ""
    }
    
//    var document : Data {
//        return vehicle.date
//    }
    
    var fuelType: Int32{
        return vehicle.fuelType
    }
    
    var model : String{
        return vehicle.model ?? ""
    }
    
    var name : String {
        return vehicle.name ?? ""
    }
    
    var odometer : Int16{
        return vehicle.odometer
    }
    
    var plate : String {
        return vehicle.plate ?? "Not specified"
    }
    
    var vehicleID: NSManagedObjectID {
        return vehicle.objectID
    }
    
    var year: Int16 {
        return vehicle.year
    }
}

struct ExpenseModel {
    var date : Date?
    var isRecursive : Bool?
    var note : String?
    var odometer : Int32?
    var price : Float?
    var type : Int16? // Enum
    
}

struct VehicleState : Hashable {
    
    var brand : String = ""
    var document : Data?
    var fuelType: Int32?
    var model : String = ""
    var name : String = ""
    var odometer : Int16?
    var plate : String = ""
    var vehicleID: NSManagedObjectID?
    var year: Int16?
}

extension VehicleState {
    
    static func fromVehicleViewModel(vm: VehicleViewModel) -> VehicleState{
        var vehicleS = VehicleState()
        vehicleS.vehicleID = vm.vehicleID
        vehicleS.odometer = vm.odometer
        vehicleS.brand = vm.brand
        vehicleS.fuelType = vm.fuelType
        vehicleS.name = vm.name
        vehicleS.year = vm.year
        vehicleS.model = vm.model
        vehicleS.plate = vm.plate
        return vehicleS
    }
    
}
