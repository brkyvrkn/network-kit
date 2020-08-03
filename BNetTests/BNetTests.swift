//
//  BNetTests.swift
//  BNetTests
//
//  Created by Berkay Vurkan on 1.08.2020.
//  Copyright © 2020 Foo. All rights reserved.
//

import XCTest
@testable import BNet

class BNetTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    // MARK: - Typealiases
    func testTypeParameters() {
        let temp = Parameters()
        XCTAssertNotNil(temp as [String: Any])
    }

    func testTypeHTTPHeader() {
        let temp = HTTPHeader()
        XCTAssertNotNil(temp as [String: String])
    }

    func testTypeParametersMap() {
        let temp = ParametersMap()
        XCTAssertNotNil(temp as [String: Any])
    }

    // MARK: - Parameter
    func testConstantParametersStringValue() {
        let param = Parameters(dictionaryLiteral: ("key1", "value1"))
        let item = param.first
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.key)
        XCTAssertNotNil(item?.value)
        XCTAssertEqual(item?.key, "key1")
        XCTAssertNotNil(item?.value as? String)
        XCTAssertEqual(item?.value as? String, "value1")
    }

    func testConstantParametersIntValue() {
        let param = Parameters(dictionaryLiteral: ("key1", 1))
        let item = param.first
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.key)
        XCTAssertNotNil(item?.value)
        XCTAssertEqual(item?.key, "key1")
        XCTAssertNotNil(item?.value as? Int)
        XCTAssertEqual(item?.value as? Int, 1)
    }

    func testConstantParametersDoubleValue() {
        let param = Parameters(dictionaryLiteral: ("key1", 1.2))
        let item = param.first
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.key)
        XCTAssertNotNil(item?.value)
        XCTAssertEqual(item?.key, "key1")
        XCTAssertNotNil(item?.value as? Double)
        XCTAssertEqual(item?.value as? Double, 1.2)
    }

    func testConstantParametersFloatValue() {
        let val: Float = 3.2
        let param = Parameters(dictionaryLiteral: ("key1", val))
        let item = param.first
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.key)
        XCTAssertNotNil(item?.value)
        XCTAssertEqual(item?.key, "key1")
        XCTAssertNotNil(item?.value as? Float)
        XCTAssertEqual(item?.value as? Float, 3.2)
    }

    // MARK: - HTTP Header
    func testConstantHeaderValue() {
        let header = HTTPHeader(dictionaryLiteral: ("key1", "value1"))
        let item = header.first
        XCTAssertNotNil(item)
        XCTAssertNotNil(item?.key)
        XCTAssertNotNil(item?.value)
        XCTAssertEqual(item?.key, "key1")
        XCTAssertEqual(item?.value, "value1")
    }

    // MARK: - HTTP Methods
    func testHTTPMethodGetValue() {
        XCTAssertEqual("GET", HTTPMethods.get.rawValue)
    }

    func testHTTPMethodPutValue() {
        XCTAssertEqual("PUT", HTTPMethods.put.rawValue)
    }

    func testHTTPMethodPostValue() {
        XCTAssertEqual("POST", HTTPMethods.post.rawValue)
    }

    func testHTTPMethodDeleteValue() {
        XCTAssertEqual("DELETE", HTTPMethods.delete.rawValue)
    }

    func testHTTPMethodPathValue() {
        XCTAssertEqual("PATCH", HTTPMethods.patch.rawValue)
    }

    func testHTTPMethodCopyValue() {
        XCTAssertEqual("COPY", HTTPMethods.copy.rawValue)
    }

    // MARK: - BNetResponse
    func testResponseMessageContinue() {
        XCTAssertNotEqual(BNetResponse.continue_.message, "")
    }

    func testResponseMessageSwitch() {
        XCTAssertNotEqual(BNetResponse.switchingProtocol.message, "")
    }

    func testResponseMessageProcessing() {
        XCTAssertNotEqual(BNetResponse.processing.message, "")
    }

    func testResponseMessageEarlyHints() {
        XCTAssertNotEqual(BNetResponse.earlyHints.message, "")
    }

    func testResponseMessageOk() {
        XCTAssertNotEqual(BNetResponse.ok.message, "")
    }

    func testResponseMessageCreated() {
        XCTAssertNotEqual(BNetResponse.created.message, "")
    }

    func testResponseMessageAccepted() {
        XCTAssertNotEqual(BNetResponse.accepted.message, "")
    }

    func testResponseMessageNoContent() {
        XCTAssertNotEqual(BNetResponse.noContent.message, "")
    }

    func testResponseMessageNotModified() {
        XCTAssertNotEqual(BNetResponse.notModified.message, "")
    }

    func testResponseMessageBadRequest() {
        XCTAssertNotEqual(BNetResponse.badRequest.message, "")
    }

    func testResponseMessageUnauthorized() {
        XCTAssertNotEqual(BNetResponse.unauthorized.message, "")
    }

    func testResponseMessageForbidden() {
        XCTAssertNotEqual(BNetResponse.forbidden.message, "")
    }

    func testResponseMessageNotFound() {
        XCTAssertNotEqual(BNetResponse.notFound.message, "")
    }

    func testResponseMessageConflict() {
        XCTAssertNotEqual(BNetResponse.conflict.message, "")
    }

    func testResponseMessageInternalServer() {
        XCTAssertNotEqual(BNetResponse.internalServerError.message, "")
    }

    // MARK: - BNetError
    func testErrorDescriptionEnvironment() {
        XCTAssertNotEqual(BNetError.environmentError.description, "")
    }

    func testErrorDescriptionCoding() {
        XCTAssertNotEqual(BNetError.codingError.description, "")
    }

    func testErrorDescriptionMissingURL() {
        XCTAssertNotEqual(BNetError.missingURLError.description, "")
    }

    func testErrorDescriptionMissingParameter() {
        XCTAssertNotEqual(BNetError.missingParametersError.description, "")
    }

    func testErrorDescriptionConnection() {
        XCTAssertNotEqual(BNetError.connectionFailed.description, "")
    }

    func testErrorDescriptionNoResponse() {
        XCTAssertNotEqual(BNetError.noResponse.description, "")
    }

    func testErrorDescriptionResponse() {
        XCTAssertNotEqual(BNetError.responseError(responseType: .accepted).description, "")
    }

    func testErrorDescriptionCustom() {
        let errMsg = "error message"
        let err = BNetError.customError(id: -1, message: errMsg)
        XCTAssertEqual(err.description, "error message")
    }

    // MARK: - Extensions
    func testAsStringParamsSingle() {
        let dict = Dictionary(dictionaryLiteral: ("key", "value"))
        XCTAssertEqual(dict.asStringParams, "key=value")
    }

    func testAsStringParamsMultiple() {
        let dict = ["key": "value", "key2": "value2"]
        XCTAssert(dict.asStringParams.contains("&"))
    }

    func testStringDataEncode() {
        let dict = ["key": "value"]
        XCTAssertNotNil(dict.asStringData)
    }

    func testStringDataDecode() {
        let dict = ["key": "value"]
        let dictData = dict.asStringData
        XCTAssertNotNil(dictData)
        XCTAssertEqual(String(data: dictData!, encoding: .utf8), "key=value")
    }

    // MARK: - URL Components
    func testURLComponents() {
        var comp = URLComponents()
        let param: [String : String] = ["param": "value", "param2": "2"]
        comp.setQueryItems(from: param)
        XCTAssertNotNil(comp.queryItems)
    }

    func testURLComponentsCount() {
        var comp = URLComponents()
        let param: [String : String] = ["param": "value", "param2": "2"]
        comp.setQueryItems(from: param)
        XCTAssertEqual(comp.queryItems?.count, 2)
    }

    // MARK: - Header Keys
    func testHeaderKeyAuthentication() {
        XCTAssertEqual(HTTPHeaderKeys.Authentication.www_authenticate.rawValue, "WWW-Authenticate")
        XCTAssertEqual(HTTPHeaderKeys.Authentication.authorization.rawValue, "Authorization")
        XCTAssertEqual(HTTPHeaderKeys.Authentication.proxy_authenticate.rawValue, "Proxy_Authenticate")
        XCTAssertEqual(HTTPHeaderKeys.Authentication.proxy_authorization.rawValue, "Proxy_Authorization")
    }

    func testHeaderKeyCaching() {
        XCTAssertEqual(HTTPHeaderKeys.Caching.age.rawValue, "Age")
        XCTAssertEqual(HTTPHeaderKeys.Caching.cache_control.rawValue, "Cache-Control")
        XCTAssertEqual(HTTPHeaderKeys.Caching.expires.rawValue, "Expires")
        XCTAssertEqual(HTTPHeaderKeys.Caching.pragma.rawValue, "Pragma")
        XCTAssertEqual(HTTPHeaderKeys.Caching.warning.rawValue, "Warning")
    }

    func testHeaderKeyClientHints() {
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.accept_ch.rawValue, "Accept-CH")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.content_dpr.rawValue, "Content-DPR")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.dpr.rawValue, "DPR")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.downlink.rawValue, "Downlink")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.save_data.rawValue, "Save-Data")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.viewport_width.rawValue, "Viewport-Width")
        XCTAssertEqual(HTTPHeaderKeys.ClientHints.width.rawValue, "Width")
    }

    // MARK: - HeaderValues
    func testHeaderValuesContentType() {
        let jsonVal = HTTPHeaderValues.ContentType.application(subtype: "json")
        let audioVal = HTTPHeaderValues.ContentType.audio(subtype: "mp3")
        let imageVal = HTTPHeaderValues.ContentType.image(subtype: "jpg")
        let multipartVal = HTTPHeaderValues.ContentType.multipart(subtype: "form")
        let textVal = HTTPHeaderValues.ContentType.text(subtype: "txt")
        let videoVal = HTTPHeaderValues.ContentType.video(subtype: "mp4")
        XCTAssertEqual(jsonVal.value, "application/json")
        XCTAssertEqual(audioVal.value, "audio/mp3")
        XCTAssertEqual(imageVal.value, "image/jpg")
        XCTAssertEqual(multipartVal.value, "multipart/form")
        XCTAssertEqual(textVal.value, "text/txt")
        XCTAssertEqual(videoVal.value, "video/mp4")
        XCTAssertEqual(jsonVal.parametrizedValue(with: ("_key", "val")), "application/json_key=val")
    }

    // MARK: - Encodables
    func testEncodableDictionary() {
        let config = BNetManager()._config
        XCTAssertNotNil(config.dictionary)
        XCTAssertEqual(config.dictionary?.keys.count, 2)
        XCTAssertEqual(config.dictionary?.values.count, 2)
    }

    // MARK: - Environements
    func testEnvironmentValues() {
        let dev = BNetEnvironment.development(text: "dev")
        let local = BNetEnvironment.local(text: "local")
        let test = BNetEnvironment.test(text: "test")
        let prod = BNetEnvironment.production(text: "prod")

        XCTAssertEqual(dev.value, "dev")
        XCTAssertEqual(local.value, "local")
        XCTAssertEqual(test.value, "test")
        XCTAssertEqual(prod.value, "prod")
    }

    // MARK: - Manager
    func testManagerToken() {
        let manager = BNetManager.shared
        XCTAssertEqual(manager.getToken(), "")
        manager.setToken("token")
        XCTAssertEqual(manager.getToken(), "token")
    }

    // MARK: - Encoder
    func testFormBodyEncoder() throws {
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        let params: Parameters = ["key1": "value1", "key2": "value2"]
        try? FormBodyParameterEncoding.encode(urlRequest: &req, parameters: params)
        XCTAssertNotNil(req.httpBody)
        let bodyStr = String(data: req.httpBody!, encoding: .utf8)
        XCTAssertNotNil(bodyStr)
        XCTAssertEqual(bodyStr!, params.asStringParams)
    }

    func testQueryParameterEncoder() throws {
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        let params: Parameters = ["key": "value"]
        try? QueryParameterEncoding.encode(urlRequest: &req, parameters: params)
        XCTAssertNotNil(req.url)
        XCTAssertEqual(req.url!.absoluteString, "https://www.google.com?key=value")
    }

    func testQueryParameterEncoderThrows() {
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        let params: Parameters = ["key": 0]
        try? QueryParameterEncoding.encode(urlRequest: &req, parameters: params)
        XCTAssertNotNil(req.url)
        XCTAssertEqual(req.url!.absoluteString, "https://www.google.com")
    }

    func testQueryParameterEncoderThrowsURL() {
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        req.url = nil
        let params: Parameters = ["key": "value"]
        try? QueryParameterEncoding.encode(urlRequest: &req, parameters: params)
        XCTAssertNil(req.url)
    }

    func testJSONParameterEncoder() throws {
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        let params: Parameters = ["key": "value"]
        try? JSONParameterEncoding.encode(urlRequest: &req, parameters: params)
        XCTAssertNotNil(req.httpBody)
        let bodyStr = String(data: req.httpBody!, encoding: .utf8)
        XCTAssertNotNil(bodyStr)
        XCTAssertEqual(bodyStr!, "{\n  \"key\" : \"value\"\n}")
    }

    func testJSONParameterEncoderWithoutQuery() throws {
        let model = BNetConfig(baseURL: "www.google.com", env: "dev")
        let googleURL = URL(string: "https://www.google.com")
        XCTAssertNotNil(googleURL)
        var req = URLRequest(url: googleURL!)
        try? JSONParameterEncoding.encode(urlRequest: &req, object: model)
        XCTAssertNotNil(req.httpBody)
        let bodyStr = String(data: req.httpBody!, encoding: .utf8)
        XCTAssertNotNil(bodyStr)
        XCTAssertEqual(bodyStr!, "{\"env\":\"dev\",\"baseURL\":\"www.google.com\"}")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
