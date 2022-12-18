//
//  FavoriteListViewModelUnitTest.swift
//  BootcampFinalProjectTests
//
//  Created by Tolga Kağan Aysu on 18.12.2022.
//

import XCTest
@testable import BootcampFinalProject

final class FavoriteListViewModelUnitTest: XCTestCase {

    lazy var viewModel =  FavoriListViewModel()
    var fetchExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
//        viewModel = FavoriListViewModel()
        viewModel.view = self
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
        viewModel.getFavoriteGames()
        fetchExpectation = expectation(description: "numberOfRowsInSection")
        waitForExpectations(timeout: 3)
        
        //Then
        XCTAssertGreaterThan(viewModel.numberOfRowsInSection(), 0)
    }
    
    func test_cellForItemAt() throws {
        //Given
        XCTAssertNil(viewModel.selectedFavoriteGame)
        
        
        //When
        viewModel.getFavoriteGames()
        fetchExpectation = expectation(description: "fetchFavoriGame")
        waitForExpectations(timeout: 3)
        viewModel.selectedFavoriteGame = viewModel.cellForRowItem(at: 1)
       
        //Then
        XCTAssertNotNil(viewModel.selectedFavoriteGame)
    }
    
    func test_didSelectRow() throws {
        //Given
        XCTAssertNil(viewModel.selectedFavoriteGame)
        
        //When
        viewModel.getFavoriteGames()
        fetchExpectation = expectation(description: "fetchFavoriGame")
        waitForExpectations(timeout: 3)
        
        viewModel.didSelectRowAt(at: 0)
        fetchExpectation = expectation(description: "did select row")
        waitForExpectations(timeout: 3)
        
        XCTAssertNotNil(viewModel.selectedFavoriteGame)
        
    }
    
    func test_deleteButton(){
        //Given
        viewModel.getFavoriteGames()
        let firstCount = viewModel.numberOfRowsInSection()
        XCTAssertGreaterThan(firstCount, 0)
        
        //When
        viewModel.deleteButtonAction(at: 0)
        fetchExpectation = expectation(description: "deleted game")
        waitForExpectations(timeout: 3)
        
        //Then
        XCTAssertNotEqual(firstCount, viewModel.numberOfRowsInSection())
    }
    
    
    
    
}

extension FavoriteListViewModelUnitTest: FavoriteListVCDelegate {
   
    
    func tableViewReloadData() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func prepareTableView() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func performSegue(identifier: String) {
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
}
