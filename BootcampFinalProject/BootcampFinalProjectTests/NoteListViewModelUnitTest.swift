//
//  NoteListViewModelUnitTest.swift
//  BootcampFinalProjectTests
//
//  Created by Tolga Kağan Aysu on 18.12.2022.
//

import XCTest
@testable import BootcampFinalProject

final class NoteListViewModelUnitTest: XCTestCase {
    lazy var viewModel =  NoteListViewModel()
    lazy var addNoteViewModel = AddNewNoteViewModel()
    var newNote: NewNote!
    var fetchExpectation: XCTestExpectation?
    override func setUp() {
        super.setUp()
        viewModel.view = self
        self.newNote = NewNote(id: "id",
                                          gameName: "name",
                                          title: "title",
                                          text: "text")
        addNoteViewModel.saveNote(newNote: newNote)
    }
    
    func test_viewDidLoad(){
        viewModel.viewDidLoad()
        fetchExpectation = expectation(description: "viewDidLoad")
        waitForExpectations(timeout: 10)
    }
    
    func test_numberOfRowsInSection() {
        //Given
        XCTAssertEqual(viewModel.numberOfRowsInSection(), 0)
       
        //When
        viewModel.getAllNote()
        fetchExpectation = expectation(description: "numberOfRowsInSection")
        waitForExpectations(timeout: 3)
        
        //Then
        XCTAssertGreaterThan(viewModel.numberOfRowsInSection(), 0)
    }
    
//    func test_cellForItemAt() throws {
//        //Given
//        XCTAssertNil(viewModel)
//
//
//        //When
//        viewModel.getAllNote()
//        fetchExpectation = expectation(description: "fetchNote")
//        waitForExpectations(timeout: 3)
//        viewModel.selectedFavoriteGame = viewModel.cellForRowAt(at: 1)
//
//        //Then
//        XCTAssertNotNil(viewModel.selectedFavoriteGame)
//    }
    
    func test_trailingSwipeActionsConfigurationForRow() {
        addNoteViewModel.saveNote(newNote: newNote)
        viewModel.getAllNote()
        //Given
        let firstCount = viewModel.numberOfRowsInSection()
        var secondCount = firstCount
        XCTAssertEqual(firstCount, secondCount)
        
        //When
        viewModel.trailingSwipeActionsConfigurationForRowAt(at: 0)
        fetchExpectation = expectation(description: "deleted note")
        waitForExpectations(timeout: 3)
        secondCount = viewModel.numberOfRowsInSection()
        
        
        //Then
        XCTAssertNotEqual(firstCount, secondCount)
    }
 
}

extension NoteListViewModelUnitTest: NoteListVCDelegate {
    func prepareTableView() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func preparePresent(note: BootcampFinalProject.Note?) {
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
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func present(with viewControllerID: String) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    func stopAnimating() {
        
    }
    
    func dismiss() {
        
    }
    
    
}
