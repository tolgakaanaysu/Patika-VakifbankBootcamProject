//
//  CoreDataNoteClient.swift
//  BootcampFinalProject
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import Foundation

final class CoreDataNoteClient {
    //MARK: - Property
    static let shared: CoreDataNoteClient = CoreDataNoteClient()
    private let entityName = "Note"
    private let coredata = CoreDataManager.shared
    private init(){}
    
    //MARK: - METHODS
    func saveNote(note: Note, completion: @escaping(Result<CoreDataCustomSuccesMessage,CoreDataCustomError>) -> Void){
        coredata.saveObject(entityName: self.entityName) { object in
            object.setValue(note.text, forKey: "text")
            object.setValue(note.date, forKey: "date")
            object.setValue(note.title, forKey: "title")
            object.setValue(note.gameName, forKey: "gameName")
            object.setValue(note.id, forKey: "id")
        } completion: { result in
            completion(result)
        }
    }
    
    func deleteNote(note: Note, completion: @escaping(Result<CoreDataCustomSuccesMessage,CoreDataCustomError>) -> Void) {
        coredata.deleteObject(model: note) { result in
           completion(result)
        }
    }
    
    func getNote(by id: String) -> Note? {
        coredata.getObject(id: id, entityName: entityName)
    }
    
    func getAllNote(comletion: @escaping(Result<[Note],CoreDataCustomError>) -> Void){
        coredata.getAllObjects(entityName: entityName, responseType: Note.self) { result in
            comletion(result)
        }
    }
}
