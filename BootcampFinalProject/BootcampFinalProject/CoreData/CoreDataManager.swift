//
//  CoreDataManager.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager: NSObject{
    //MARK: - Property
    static let shared = CoreDataManager()
    private let managedContext: NSManagedObjectContext!
    
    //MARK: - init
    private override init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        managedContext = persistentContainer.viewContext
    }
    
    //MARK: - Methods
    func saveObject(entityName: String ,willSaveObject: (NSManagedObject) -> Void, completion: @escaping(Result<CoreDataCustomSuccesMessage, CoreDataCustomError>) -> Void) {
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext) else { return }
        let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
        willSaveObject(managedObject)
        
        do {
            try managedContext.save()
            completion(.success(CoreDataCustomSuccesMessage.saveSuccess))
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
            completion(.failure(CoreDataCustomError.saveError))
        }
    }
    
    func deleteObject<modelType: NSManagedObject>(model: modelType, completion: @escaping(Result<CoreDataCustomSuccesMessage,CoreDataCustomError>) -> Void){
        managedContext.delete(model)
        do {
            try managedContext.save()
            completion(.success(CoreDataCustomSuccesMessage.deleteSucces))
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(.failure(CoreDataCustomError.deleteError))
        }
    }
    
    func getAllObjects<modelType: NSManagedObject>(entityName: String, responseType: modelType.Type, completion: @escaping(Result<[modelType],CoreDataCustomError>) -> Void){
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entityName)
        
        do {
            if let objectList = try managedContext.fetch(fetchRequest) as? [modelType]{
                completion(.success(objectList))
            }
        } catch let error as NSError {
            print(error.localizedDescription)
            completion(.failure(CoreDataCustomError.loadError))
        }
    }
    
    func getObject<ObjectType: NSManagedObject>(id: String, entityName: String) -> ObjectType? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "id = %@", id)
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results.first as? ObjectType
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}

//MARK: - Enums
enum CoreDataCustomError {
    case saveError
    case loadError
    case updateError
    case deleteError
}

extension CoreDataCustomError: Error {
    var message: String {
        switch self {
        case .loadError:
            return "Failed to load"
        case .saveError:
            return "Failed to save"
        case .updateError:
            return "Failed to update"
        case .deleteError:
            return "Failed to delete"
        }
    }
}

enum CoreDataCustomSuccesMessage {
    case saveSuccess
    case updateSucces
    case deleteSucces
}

extension CoreDataCustomSuccesMessage {
    var message: String {
        switch self {
        case .saveSuccess:
            return "Successfully saved"
        case .updateSucces:
            return "Successfully edited"
        case .deleteSucces:
            return "Successfully deleted"
        }
    }
}

