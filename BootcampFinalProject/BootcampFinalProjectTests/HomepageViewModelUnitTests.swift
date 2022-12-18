//
//  BootcampFinalProjectTests.swift
//  BootcampFinalProjectTests
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import XCTest
@testable import BootcampFinalProject

final class HomepageViewModelUnitTests: XCTestCase {

    var viewModel: HomepageViewModel!
    var fetchExpectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        viewModel = HomepageViewModel()
        viewModel.view = self
        fetchExpectation = expectation(description: "fetchMovies")
    }
    
    func test_viewDidLoad(){
        viewModel.viewDidLoad()
        waitForExpectations(timeout: 10)
    }
    
    
    func test_numberOfItemsInSection() throws {
        //Given
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 0)
       
        //When
        viewModel.getAllGames()
        waitForExpectations(timeout: 10)
        
        //Then
        XCTAssertEqual(viewModel.numberOfItemsInSection(), 20)

    }
    
    func test_cellForItemAt() throws {
        viewModel.getAllGames()
        
        waitForExpectations(timeout: 10)
        
        let itemAtZero = viewModel.cellForItemAt(at: 5)
        XCTAssertEqual(itemAtZero?.id, 5679)
        XCTAssertEqual(itemAtZero?.name, "The Elder Scrolls V: Skyrim")
        XCTAssertEqual(itemAtZero?.rating, 4.42)
       
    }
    
    func test_getGameID() {
        //Given
        XCTAssertNil(viewModel.getGameID())
        
        //When
        viewModel.getAllGames()
        waitForExpectations(timeout: 10)
        
        viewModel.didSelectItemAt(at: 5)
        XCTAssertEqual(viewModel.getGameID(),5679)
    }
}

extension HomepageViewModelUnitTests:HomepageViewControllerDelegate {
    func prepareComponents() {
        
    }
    
    func collectionViewReloadData() {
        fetchExpectation.fulfill()
    }
    
    func performSegue(identifier: String) {
    }
    
    func showErrorAlert(message: String) {
        
    }
    
    func showSuccessAlert(message: String) {
        
    }
    
    func startProgressAnimating() {
        
    }
    
    func stopAnimating() {
        
    }
    
    
}
