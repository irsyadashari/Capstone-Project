//
//  Capstone_SwiftUITests.swift
//  Capstone SwiftUITests
//
//  Created by Irsyad Ashari on 02/12/20.

import XCTest
import SwiftUI
@testable import Capstone_SwiftUI

class CapstoneSwiftUITests: XCTestCase {
  @EnvironmentObject var homePresenter: HomePresenter
//
//  func testHomePresenter() {
//
//    let homeUseCase = Injection.init().provideHome()
//    let homePresenter = HomePresenter(homeUseCase: homeUseCase)
//
//  }
  
  func testFavoriteChecking() {
    
    let homeView = HomeView(presenter: homePresenter)
    
    print("places from testing : \(homePresenter.places)")
    XCTAssertTrue(homeView.checkFavoriteTab()) // success if favorite is empty
  }
  
}
