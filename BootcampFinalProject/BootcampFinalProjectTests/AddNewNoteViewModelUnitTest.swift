//
//  AddNoteViewModelUnitTest.swift
//  BootcampFinalProjectTests
//
//  Created by Tolga Kağan Aysu on 18.12.2022.
//

import XCTest
@testable import BootcampFinalProject
final class AddNewNoteViewModelUnitTest: XCTestCase {
    
    lazy var viewModel = AddNewNoteViewModel()
    lazy var listViewModel = NoteListViewModel()
    var fetchExpectation: XCTestExpectation?
    var newNote: NewNote!
    var note: Note!
    override func setUp() {
        super.setUp()
        viewModel.view = self
        newNote = NewNote(id: "1",
                              gameName: "game",
                              title: "title",
                              text: "text")
        note = listViewModel.cellForRowAt(at: 0)
    }
//    
//    func test_viewDidLoad_WithNil(){
//        viewModel.viewDidLoad(note: nil)
//        fetchExpectation = expectation(description: "viewDidLoad")
//        waitForExpectations(timeout: 10)
//    }
    
//    func test_viewDidLoad_WithNote(){
//        
//        viewModel.viewDidLoad(note: note)
//        fetchExpectation = expectation(description: "viewDidLoad")
//        waitForExpectations(timeout: 10)
//    }
}

extension AddNewNoteViewModelUnitTest: AddNewNoteVCDelegate {
    func configureComponents(with note: BootcampFinalProject.Note) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func configureComponents() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func showSuccessAlert(message: String) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func startProgressAnimating() {
        
    }
    
    func stopAnimating() {
        
    }
    
    func present(with viewControllerID: String) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func dismiss() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    
}
