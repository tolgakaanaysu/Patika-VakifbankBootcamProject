//
//  GameDetailViewModel.swift
//  BootcampFinalProjectTests
//
//  Created by Tolga Kağan Aysu on 17.12.2022.
//

import XCTest
@testable import BootcampFinalProject

final class DetailsViewModelTests: XCTestCase {

    var viewModel: DetailsViewModel!
    var fetchExpectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        viewModel = DetailsViewModel()
        viewModel.view = self
        viewModel.id = 200
       
        
    }
    
    
    func test_viewDidLoad() {
        viewModel.viewDidLoad()
        fetchExpectation = expectation(description: "viewDidload")
        waitForExpectations(timeout: 10)
    }
    
    func test_gameIsNotFavorite() throws {
        XCTAssertFalse(viewModel.gameIsFavorite)
        viewModel.gameIsFavorite = true
        
        
        viewModel.id = -1
        viewModel.getGameIsFavorite()
        fetchExpectation = expectation(description: "gameIsNotFavorite")
        waitForExpectations(timeout: 10)
        
        XCTAssertFalse(viewModel.gameIsFavorite)
      
    }
    
    func test_gameIsFavorite(){
        XCTAssertFalse(viewModel.gameIsFavorite)
        
        viewModel.getGameIsFavorite()
        fetchExpectation = expectation(description: "game is favorite error")
        waitForExpectations(timeout: 10)
        
        XCTAssertTrue(viewModel.gameIsFavorite)
    }
   
    func test_getGameDetailSuccess(){
        XCTAssertNil(viewModel.game)
       
        viewModel.getGameDetails(by: viewModel.id)
        fetchExpectation = expectation(description: "game details success error")
        waitForExpectations(timeout: 10)
        XCTAssertNotNil(viewModel.game)
    }

    func test_getGameDetailFail(){
        XCTAssertNil(viewModel.game)

        viewModel.getGameDetails(by: -99)
        fetchExpectation = expectation(description: "game details fail error")
        waitForExpectations(timeout: 10)

        XCTAssertNil(viewModel.game)
    }
    
    func test_savedFavori() {
        XCTAssertFalse(viewModel.gameIsFavorite)
              
        viewModel.getGameDetails(by: viewModel.id)
        fetchExpectation = expectation(description: "get game details error")
        waitForExpectations(timeout: 10)

       
        viewModel.favoriteButtonClicked()
        fetchExpectation = expectation(description: "game save error")
        waitForExpectations(timeout: 10)
      
        
        XCTAssertTrue(viewModel.gameIsFavorite)
    }
    
    func test_deleteFavori(){
        XCTAssertFalse(viewModel.gameIsFavorite)
     
        viewModel.getGameDetails(by: viewModel.id)
        fetchExpectation = expectation(description: "get game details")
        waitForExpectations(timeout: 10)
        
        viewModel.favoriteButtonClicked()
        fetchExpectation = expectation(description: "game saved error")
        waitForExpectations(timeout: 3)

        viewModel.getGameIsFavorite()
        fetchExpectation = expectation(description: "game saved error")
        waitForExpectations(timeout: 3)
        
        viewModel.favoriteButtonClicked()
        fetchExpectation = expectation(description: "game deleted error")
        waitForExpectations(timeout: 3)
        
        XCTAssertFalse(viewModel.gameIsFavorite)
    }
}

extension DetailsViewModelTests: DetailsViewControllerDelegate {
    func pushViewController(with viewControllerID: String) {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
       
    }
    
    func popViewController() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func dataNotFound() {
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func prepareInterfaceComponent(game: BootcampFinalProject.GameDetail) {
       
        DispatchQueue.main.async {
            self.fetchExpectation?.fulfill()
            self.fetchExpectation = nil
        }
    }
    
    func changeButtonColor(_ gameIsFavorite: Bool) {
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
