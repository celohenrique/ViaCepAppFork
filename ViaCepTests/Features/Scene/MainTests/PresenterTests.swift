import XCTest
@testable import ViaCep

final class PresenterTests: XCTestCase {
    typealias DataCepMock = DataCep
    
    func test_PresentCep_WhenGetsAllOfInformationData_ShouldReturnDataCep() {
        let (sut, viewControllerSpy) = makeSut()
        
        sut.presentCep(.fixture())
        
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.expected, .fixture())
    }
    
    func test_didShowError() {
        let (sut, viewControllerSpy) = makeSut()
        let message: String = "Something was wrong..."
        
        sut.displayError(message)
        
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.errorMessage, message)
    }
    
    func test_DidDisplayInvalidCepMessage() {
        let (sut, viewControllerSpy) = makeSut()
        
        let data: DataCepMock = .fixture()
        sut.displayInvalidCepAlertMessage(data)
        
        XCTAssertEqual(viewControllerSpy.wasCalled, true)
        XCTAssertEqual(viewControllerSpy.howManyTimes, 1)
        XCTAssertEqual(viewControllerSpy.errorMessage, data.cep)
    }
}

extension PresenterTests {
    private func makeSut() -> (
        sut: MainPresenter,
        viewControllerSpy: ViewControllerSpy
    ) {
        let coordinator = MainCoordinator()
        let viewControllerSpy = ViewControllerSpy()
        let sut = MainPresenter(coordinator: coordinator)
        sut.viewController = viewControllerSpy
        return (sut, viewControllerSpy)
    }
}
