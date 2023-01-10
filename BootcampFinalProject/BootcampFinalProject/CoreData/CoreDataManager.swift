//
//  CoreDataManager.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 14.12.2022.
//

import UIKit
import CoreData

final class CoreDataManager: NSObject {
    //MARK: - Property
    private let managedContext: NSManagedObjectContext!
    private let entityName: String
    
    //MARK: - init
    init(entityName: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let persistentContainer = appDelegate.persistentContainer
        managedContext = persistentContainer.viewContext
        self.entityName = entityName
    }
    
    //MARK: - Methods
    func saveObject(willSaveObject: (NSManagedObject) -> Void, completion: @escaping(Result<CoreDataCustomSuccesMessage, CoreDataCustomError>) -> Void) {
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
    
    func getAllObjects<modelType: NSManagedObject>(responseType: modelType.Type, completion: @escaping(Result<[modelType],CoreDataCustomError>) -> Void){
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
    
    func getObject<ObjectType: NSManagedObject>(by id: String) -> ObjectType? {
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
